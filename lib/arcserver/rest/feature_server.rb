module ArcServer
  module REST
    class FeatureServer

      include HTTParty
      format :json
      # debug_output $stdout

      # The REST url of a feature service
      attr_reader :url

      # @param [String] url the REST url of a map service
      # @example
      #   ArcServer::MapServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/BloomfieldHillsMichigan/LandusePlanning/FeatureServer")
      def initialize(url)
        @url = url
      end


      def applyEdits(adds=[], updates=[], deletes=[])
        options = { body: { f: 'json', rollbackOnFailure: 'true' } }
        options[:body].merge!( { adds: adds.to_json } ) if adds.any?
        options[:body].merge!( { updates: updates.to_json } ) if updates.any?
        options[:body].merge!( { deletes: deletes.to_json } ) if deletes.any?
        self.class.post(@url, options)
      end

    end
  end
end
