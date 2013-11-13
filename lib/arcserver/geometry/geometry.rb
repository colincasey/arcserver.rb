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

      def extent
        nil
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
