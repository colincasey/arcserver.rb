# encoding: utf-8

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
            geometry: nil,
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
            f: "json"
          }.merge(attr)
        defaults.each { |k,v| instance_variable_set("@#{k}", v) }
			end

      def params
        # sanitize_params
        hash = Hash[instance_variables.map { |name| [name.to_s[1..-1].to_sym, instance_variable_get(name)] } ]
        if hash[:geometry]
          hash[:geometryType] = hash[:geometry].geometryType
          hash[:geometry] = hash[:geometry].to_json
        end
        hash
      end

      # Utility method that sanitize che query parameters
      # example:
      # where clause want that single quotes are double
      def sanitize_params
        # @where[/\w*=\'(.*)\'/].gsub(/\'/, "''")
        # @where.sub!(/\w*=\'(.*)\'/, { |s| puts s })
      end

      # Execute a query on a map layer
      # You have to specify a layer avaible on the map server:
      # http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer/0
      #
      def execute(url)
        response = self.class.get("#{url}/query", query: params)
        Graphics::FeatureSet.new(response.with_indifferent_access)
      end

		end
	end
end
