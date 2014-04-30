module ArcServer
  module Graphics
    class FeatureSet

      # include Enumerable

      attr_accessor :displayFieldName, :geometryType, :fieldAliases, :features

      def initialize(attrs={})
        @fieldAliases = attrs[:fields] if attrs[:fields]
        @geometryType = attrs[:geometryType] if attrs[:geometryType]

        if attrs[:features]
          @features = attrs[:features].map { |f| f.is_a?(Feature) ? f : Feature.create(f) }
        end

        # self
      end

      def empty?
        @features.empty?
      end

    end
  end
end
