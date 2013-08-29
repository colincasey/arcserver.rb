module ArcServer
	module Graphics
    class Feature

      include ActiveModel::Dirty

      attr_accessor :attributes
      # attr_accessor :geometry, :attributes

      def initialize(attr={})
        # @geometry = attr[:geometry] || { }
        @attributes = attr[:attributes] || { }
      end

	  end
	end
end
