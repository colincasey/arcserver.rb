module ArcServer
  module Graphics
    class FeatureSet

      attr_accessor :displayFieldName, :geometryType, :fieldAliases, :features

      def initialize(attrs={})
        @fieldAliases = attrs[:fields]
        @geometryType = attrs[:geometryType]
        @features = attrs[:features].map { |f| Feature.new(f) }
      end

      def empty?
        @features.empty?
      end

    end
  end
end
