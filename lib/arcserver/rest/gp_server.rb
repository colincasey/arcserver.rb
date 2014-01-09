# encoding: utf-8

module ArcServer
  module REST
    class GPServer

      include HTTParty
      format :json
      # debug_output $stdout

      # The REST url of a map service
      attr_reader :url

      # @param [String] url the REST url of a map service
      # @example
      #   ArcServer::GPServer.new("http://sampleserver2.arcgisonline.com/ArcGIS/rest/services/PublicSafety/EMModels/GPServer/ERGByChemical")
      def initialize(url)
        @url = url
      end

      def execute(params)
        defaults = { f: 'json' }.merge(params)
        results = self.class.get("#{url}/execute", query: defaults)
        Hash(*results['results']).with_indifferent_access
      end

      def checkJobStatus
        @status
      end

      def build_params(results, esri_job_id)

        all_params = {}
        results['results'].each do |r|
          result_param = self.class.get("#{url}/jobs/#{esri_job_id}/#{r[1]['paramUrl']}", query: { f: 'json' }).with_indifferent_access
          case result_param['dataType']
            when 'GPFeatureRecordSetLayer'
              all_params[result_param['paramName']] = Graphics::FeatureSet.new(result_param['value'])
            else
              all_params[result_param['paramName']] = result_param['value']
          end
        end
        all_params.with_indifferent_access
      end

      def submitJob(params)

        defaults = { f: 'json' }.merge(params)
        esri_job_id = self.class.get("#{url}/submitJob", query: defaults)['jobId']

        s = Rufus::Scheduler.new
        s.every '2s' do |job|

          results = self.class.get("#{url}/jobs/#{esri_job_id}", query: { f: 'json' })
          @status = results['jobStatus']

          case @status
            when 'esriJobSucceeded'
              yield build_params(results, esri_job_id)
              s.shutdown
            when 'esriJobWaiting'
              nil
            when 'esriJobSubmitted'
              nil
            when 'esriJobExecuting'
              nil
            when 'esriJobCancelled'
              nil
            when 'esriJobFailed'
              nil
            when 'esriJobCancelling'
              nil
          end
        end
        s.join

      end

    end
  end
end
