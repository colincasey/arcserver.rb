module ArcServer
  module Graphics
    class FeatureSet

      # include Enumerable

      attr_accessor :displayFieldName, :geometryType, :fieldAliases, :features

      def initialize(attrs={})
        @fieldAliases = attrs[:fields]
        @geometryType = attrs[:geometryType] || ""

        if attrs[:features]
          @features = attrs[:features].map do |feature|
            feature['geometry'] = ArcServer::Geometry::Geometry.build(feature['geometry'], @geometryType) unless feature['geometry'].is_a?(ArcServer::Geometry::Geometry)
            feature.is_a?(Feature) ? feature : Feature.new(feature)
          end
        end

        self
      end

      def empty?
        @features.empty?
      end

    end
  end
end
