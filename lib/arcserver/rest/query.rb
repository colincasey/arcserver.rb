module ArcServer
  module REST
		class Query

      include HTTParty
      format :json
      # debug_output $stdout

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
        # sanitize_params
        Hash[instance_variables.map { |name| [name.to_s[1..-1].to_sym, instance_variable_get(name)] } ]
      end

      # Utility method that sanitize che query parameters
      # example:
      # where clause want that single quotes are double
      def sanitize_params
        # @where[/\w*=\'(.*)\'/].gsub(/\'/, "''")
        # @where.sub!(/\w*=\'(.*)\'/, { |s| puts s })
      end

			def execute(url)
        response = self.class.get("#{url}/query", :query => params)
        Graphics::FeatureSet.new(response.with_indifferent_access)
			end			
		
		end
	end
end
	