module ArcServer
  module Graphics
    class FeatureSet

      # include Enumerable

      attr_accessor :displayFieldName, :geometryType, :fieldAliases, :features

      def initialize(attrs={})
        @fieldAliases = attrs[:fields]
        @geometryType = attrs[:geometryType] || ""
        @features = attrs[:features].map { |f| f.is_a?(Feature) ? f : Feature.new(f) } if attrs[:features]
        self
      end

      def empty?
        @features.empty?
      end

      # def each(&block)
      #   return enum_for(__method__) if block.nil?
      #   @features.each do |ob|
      #     block.call(ob)
      #   end
      # end

      # def [](n)
      #   @features[n] rescue nil
      # end

    end
  end
end
