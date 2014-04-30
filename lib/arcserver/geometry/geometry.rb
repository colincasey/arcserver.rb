module ArcServer
  module Geometry

    class Geometry < OpenStruct

      def self.build(geometry, geometryType)
        klass = {
            esriGeometryPoint:      ArcServer::Geometry::Point,
            esriGeometryMultipoint: ArcServer::Geometry::Multipoint,
            esriGeometryPolygon:    ArcServer::Geometry::Polygon,
            esriGeometryPolyline:   ArcServer::Geometry::Polyline,
            esriGeometryEnvelope:   ArcServer::Geometry::Envelope,
        }[geometryType.to_sym]
        klass.new(geometry) rescue nil
      end

      def self.create(geometry)

        parsed_geometry = geometry.is_a?(Hash) ? geometry.with_indifferent_access : JSON.parse(geometry).with_indifferent_access rescue {}

        if parsed_geometry[:x]
          ArcServer::Geometry::Point.new(parsed_geometry)
        elsif  parsed_geometry[:paths]
          ArcServer::Geometry::Polyline.new(parsed_geometry)
        elsif parsed_geometry[:rings]
          ArcServer::Geometry::Polygon.new(parsed_geometry)
        elsif parsed_geometry[:points]
          ArcServer::Geometry::Multipoint.new(parsed_geometry)
        elsif parsed_geometry[:ymax]
          ArcServer::Geometry::Envelope.new(parsed_geometry)
        else
          nil
        end

      end

      def geometryType
        nil
      end

      def extent
        nil
      end

    end

    class Point < Geometry

      def geometryType
        "esriGeometryPoint"
      end

    end

    class Multipoint < Geometry
      def geometryType
        "esriGeometryMultipoint"
      end
    end

    class Polygon < Geometry

      def geometryType
        "esriGeometryPolygon"
      end

      def extent
        poly = self.rings.flatten
        x = poly.values_at(*poly.each_index.select {|i| i.even?})
        y = poly.values_at(*poly.each_index.select {|i| i.odd?})
        [x.min, y.min, x.max, y.max]
      end

    end

    class Polyline < Geometry
      def geometryType
        "esriGeometryPolyline"
      end
    end

    class Envelope < Geometry
      def geometryType
        "esriGeometryEnvelope"
      end
    end

  end
end
