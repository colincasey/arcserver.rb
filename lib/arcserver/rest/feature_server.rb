module ArcServer
  module REST
    class FeatureServer

      include HTTParty
      format :json
      debug_output $stdout

      # The REST url of a feature service
      attr_reader :url

      # @param [String] url the REST url of a map service
      # @example
      #   ArcServer::MapServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/BloomfieldHillsMichigan/LandusePlanning/FeatureServer")
      def initialize(url)
        @url = url
      end


      def applyEdits(adds=[], updates=[], deletes=[])
        options = { :body => { f: 'json', rollbackOnFailure: true, adds: adds.to_json, updates: updates.to_json, deletes: deletes.to_json  } }
        self.class.post(@url, options)
      end

    end
  end
end
