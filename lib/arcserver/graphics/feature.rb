module ArcServer
	module Graphics
    class Feature

      include ActiveModel::Dirty

      attr_accessor :geometry, :attributes

      def initialize(attr={})
        @geometry, @attributes = attr['geometry'], attr['attributes']
        @attributes = attr['attributes']
      end

	  end
	end
end
