module ArcServer
	module Graphics
    class Feature

      include ActiveModel::Dirty
      attr_accessor :geometry, :attributes

      def initialize(attr={})
        @geometry = attr.with_indifferent_access[:geometry] || { }
        @attributes = attr.with_indifferent_access[:attributes] || { }
      end

	  end
	end
end
