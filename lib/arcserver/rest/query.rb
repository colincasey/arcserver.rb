module ArcServer
  module REST
		class Query
		
			attr_accessor :where, 
										:objectIds, 
										:time, 
										:geometry, 
										:geometryType, 
										:inSR, 
										:spatialRel, 
										:relationParam, 
										:outFields, 
										:returnGeometry, 
										:maxAllowableOffset, 
										:geometryPrecision, 
										:outSR, :gdbVersion, 
										:returnIdsOnly, 
										:returnCountOnly, 
										:orderByFields, 
										:groupByFieldsForStatistics, 
										:outStatistics, 
										:returnZ, 
										:returnM, 
										:f
			
			def initialize(attr={})
				attr.each { |k,v| instance_variable_set("@#{k}",v) }
			end
			
			def execute(url)
				uri = URI("#{url}/query?where=#{where}&objectIds=#{objectIds}&time=#{time}&geometry=#{geometry}&geometryType=#{geometryType}&inSR=#{inSR}&spatialRel=#{spatialRel}&relationParam=#{relationParam}&outFields=#{outFields}&returnGeometry=#{returnGeometry}&maxAllowableOffset=#{maxAllowableOffset}&geometryPrecision=#{geometryPrecision}&outSR=#{outSR}&gdbVersion=#{gdbVersion}&returnIdsOnly=#{returnIdsOnly}&returnCountOnly=#{returnCountOnly}&orderByFields=#{orderByFields}&groupByFieldsForStatistics=#{groupByFieldsForStatistics}&outStatistics=#{outStatistics}&returnZ=#{returnZ}&returnM=#{returnM}&f=pjson")
				parsed = ActiveSupport::JSON.decode(Net::HTTP.get(uri))
				parsed['features'].map { |f| Feature.new(f) }
			end			
		
		end
	end
end
	