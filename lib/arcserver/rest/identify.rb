# encoding: utf-8

module ArcServer
  module REST
    class Identify

      include HTTParty
      format :json
      # debug_output $stdout

      def initialize(attr={})
        defaults = {
          f: "json",
          geometry: "",
          geometryType: "esriGeometryEnvelope",
          sr: "",
          layerDefs: "",
          time: "",
          layerTimeOptions: "",
          layers: "all",
          tolerance: "",
          mapExtent: "",
          imageDisplay: "",
          returnGeometry: true,
          maxAllowableOffset: ""
        }.merge(attr)
        defaults.each { |k,v| instance_variable_set("@#{k}",v) }
      end

      def params
        hash = Hash[instance_variables.map { |name| [name.to_s[1..-1].to_sym, instance_variable_get(name)] } ]
        if hash[:geometry]
          hash[:geometryType] = hash[:geometry].geometryType
          hash[:geometry] = hash[:geometry].to_json
        end
        hash[:mapExtent] = hash[:mapExtent].join(',') if hash[:mapExtent]
        hash
      end

      def execute(url)
        response = self.class.get("#{url}/identify", query: params)
        response.with_indifferent_access[:results].map { |r| IdentifyResult.new(r) }
      end

    end

    class IdentifyResult

      attr_accessor :layerId, :layerName, :value, :displayFieldName, :feature

      def initialize(attrs={})
        @layerId = attrs[:layerId]
        @layerName = attrs[:layerName]
        @value = attrs[:value]
        @displayFieldName = attrs[:displayFieldName]
        @geometryType = attrs[:geometryType]
        @geometry = ArcServer::Geometry::Geometry.build(attrs[:geometry], @geometryType)
        @feature = Graphics::Feature.new({ geometry: @geometry, attributes: attrs[:attributes] })
      end

    end

  end
end
