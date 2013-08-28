module ArcServer
	module Graphics
	
		attr_accessor :geometry, :attributes
		
		def initialize(attr={})
			@geometry = {}.merge(attr['geometry'])
			@attributes = {}.merge(attr['attributes'])
		end
		
		def to_json
			ActiveSupport::JSON.encode( { attributes: @attributes } )
		end	
	
	end
end