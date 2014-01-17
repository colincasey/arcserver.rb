# encoding: utf-8

module ArcServer
  module REST
    class GeometryService

      include HTTParty
      format :json
      # debug_output $stdout

      # The REST url of a feature service
      attr_reader :url

      # @param [String] url the REST url of a map service
      def initialize(url)
        @url = url
      end

      def to_params(hash)
        if hash[:geometries]
          hash[:geometries] = hash[:geometries].to_json
        end
        hash
      end

      def project(attrs={})
        params = {
            f: 'json',
            geometries: '',
            inSR: '',
            outSR: ''
        }.merge(attrs)
        response = self.class.get("#{url}/project", query: to_params(params))
        response["geometries"].map { |g| ArcServer::Geometry::Geometry.create(g) }
      end

      def buffer(attrs={})
        params = {
            f: 'json',
            geometries: '',
            inSR: '',
            outSR: '',
            bufferSR: '',
            distances: '',
            unit: '',
            unionResults: 'false'
        }.merge(attrs)
        response = self.class.get("#{url}/buffer", query: to_params(params))
        response["geometries"].map { |g| ArcServer::Geometry::Geometry.create(g) }
      end

    end
  end
end
