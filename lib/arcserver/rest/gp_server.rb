# encoding: utf-8

module ArcServer
  module REST
    class GPServer

      include HTTParty
      format :json
      debug_output $stdout

      # The REST url of a map service
      attr_reader :url

      # @param [String] url the REST url of a map service
      # @example
      #   ArcServer::GPServer.new("http://sampleserver2.arcgisonline.com/ArcGIS/rest/services/PublicSafety/EMModels/GPServer/ERGByChemical")
      def initialize(url)
        @url = url
      end

      def submitJob(params)

        defaults = { f: 'json' }.merge(params)
        job_id = self.class.get("#{url}/submitJob", query: defaults)['jobId']

        s = Rufus::Scheduler.new
        s.every '5s' do |job|
          result = self.class.get("#{url}/jobs/#{job_id}", query: { f: 'json' })
          if result['jobStatus'] == 'esriJobSucceeded'
            features = []
            result['results'].each do |r|
              features << Graphics::FeatureSet.new(self.class.get("#{url}/jobs/#{job_id}/#{r[1]['paramUrl']}", query: { f: 'json' })['value'].with_indifferent_access)
            end
            yield features
            s.shutdown
          end
        end
        s.join

      end

    end
  end
end
