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
      # ArcServer::MapServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/BloomfieldHillsMichigan/LandusePlanning/FeatureServer")
      def initialize(url)
        @url = url
      end

      def applyEdits(layer, adds=[], updates=[], deletes=[])
        options = { body: { f: 'json', rollbackOnFailure: 'true' } }
        options[:body].merge!( { adds: adds.to_json(only: [ :geometry, :attributes] ) } ) if adds.any?
        options[:body].merge!( { updates: updates.to_json(only: [ :geometry, :attributes] ) } ) if updates.any?
        options[:body].merge!( { deletes: deletes } ) unless deletes.empty?
        results = self.class.post("#{@url}/#{layer}/applyEdits", options)
        results.with_indifferent_access
      end

    end
  end
end
