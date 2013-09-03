module ArcServer
	module Graphics
    class Feature

      include ActiveModel::Dirty
      attr_accessor :geometry, :attributes

      def initialize(attr={})
        @geometry = attr.with_indifferent_access[:geometry] || { }
        @attributes = attr.with_indifferent_access[:attributes] || { }
      end

      def geometry=(value)
        attribute_will_change!('geometry') if @geometry != value
        @geometry = value
      end

      def geometry_changed?
        changed.include?('geometry')
      end

	  end
	end
end
