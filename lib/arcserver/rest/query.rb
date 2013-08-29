module ArcServer
  module REST
		class Query

      include HTTParty
      format :json

			def initialize(attr={})
        defaults = {
            where: "",
            objectIds: "",
            time: "",
            geometry: "",
            geometryType: "esriGeometryEnvelope",
            inSR: "",
            spatialRel: "esriSpatialRelIntersects",
            relationParam: "",
            outFields: "*",
            returnGeometry: true,
            maxAllowableOffset: "",
            geometryPrecision: "",
            outSR: "",
            gdbVersion: "",
            returnIdsOnly: false,
            returnCountOnly: false,
            orderByFields: "",
            groupByFieldsForStatistics: "",
            outStatistics: "",
            returnZ: false,
            returnM: false,
            f: "pjson"
          }.merge(attr)
        defaults.each { |k,v| instance_variable_set("@#{k}",v) }
			end

      def params
        Hash[instance_variables.map { |name| [name.to_s[1..-1].to_sym, instance_variable_get(name)] } ]
      end

			def execute(url)
        response = self.class.get("#{url}/query", :query => params)
        Graphics::FeatureSet.new(response)
			end			
		
		end
	end
end
	