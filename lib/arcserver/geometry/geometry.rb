module ArcServer
  module Geometry

    class Geometry < OpenStruct

      attr_accessor :spatialReference

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

      def self.create(json)

        parsed = json.is_a?(Hash) ? json : JSON.parse(json)

        if parsed['x']
          ArcServer::Geometry::Point.new(parsed)
        elsif  parsed['paths']
          ArcServer::Geometry::Polyline.new(parsed)
        elsif parsed['rings']
          ArcServer::Geometry::Polygon.new(parsed)
        elsif parsed['points']
          ArcServer::Geometry::Multipoint.new(parsed)
        elsif parsed['ymax']
          ArcServer::Geometry::Envelope.new(parsed)
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
