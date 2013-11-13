module ArcServer
	module Graphics
    class Feature

      attr_accessor :geometry, :attributes

      def initialize(attr={})
        @geometry = attr[:geometry]
        @attributes = attr[:attributes] || { }
      end

      def [](key)
        send key
      end

	  end
	end
end
