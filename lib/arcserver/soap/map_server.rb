# encoding: utf-8

module ArcServer
  module SOAP
    class MapServer < Handsoap::Service
      on_create_document do |doc|
        doc.alias "env", "http://schemas.xmlsoap.org/soap/envelope/"
        doc.alias "ns",  "http://www.esri.com/schemas/ArcGIS/9.3"
      end

      def on_before_dispatch
        self.class.endpoint(:uri => @soap_url, :version => 1)
      end

      def initialize(soap_url, protocol_version=2)
        @soap_url = soap_url
      end

      def get_default_map_name
        response = invoke("ns:GetDefaultMapName")
        node = response.document.xpath('//tns:GetDefaultMapNameResponse/Result', ns).first
        parse_default_map_name_result(node)
      end

      def get_legend_info(args = {})
        image_return_type = args[:image_return_url] ? "esriImageReturnURL" : "esriImageReturnMimeData"
        response = invoke("ns:GetLegendInfo") do |message|
          message.add "MapName", args[:map_name] || get_default_map_name
          message.add "ImageType" do |image_type|
            image_type.add "ImageReturnType", image_return_type
            image_type.add "ImageFormat", "esriImagePNG24"
          end
        end
        node = response.document.xpath('//tns:GetLegendInfoResponse/Result', ns).first
        parse_legend_info_result(node)
      end

      private
      def ns
        { 'tns', 'http://www.esri.com/schemas/ArcGIS/9.3' }
      end

      # helpers
      def parse_default_map_name_result(node)
        xml_to_str(node, './text()')
      end

      def parse_legend_info_result(node)
        node.xpath('./MapServerLegendInfo', ns).collect { |child| parse_map_server_legend_info(child) }
      end

      def parse_map_server_legend_info(node)
        {
          :layer_id => xml_to_int(node, "./LayerID/text()"),
          :name => xml_to_str(node, "./Name/text()"),
          :legend_groups => node.xpath('./LegendGroups/MapServerLegendGroup', ns).collect { |child| parse_map_server_legend_group(child) }
        }
      end

      def parse_map_server_legend_group(node)
        {
          :heading => xml_to_str(node, "./Heading/text()"),
          :legend_classes => node.xpath("./LegendClasses/MapServerLegendClass", ns).collect { |child| parse_map_server_legend_class(child) }
        }
      end

      def parse_map_server_legend_class(node)
        {
          :label => xml_to_str(node, "./Label/text()"),
          :descriptions => xml_to_str(node, "./Description/text()"),
          :symbol_image => {
            :image_data => xml_to_str(node, "./SymbolImage/ImageData/text()"),
            :image_url  => xml_to_str(node, "./SymbolImage/ImageURL/text()"),
            :image_height => xml_to_int(node, "./SymbolImage/ImageHeight/text()"),
            :image_width => xml_to_int(node, "./SymbolImage/ImageWidth/text()"),
            :image_dpi => xml_to_int(node, "./SymbolImage/ImageDPI/text()")
          },
          :transparent_color => {
            :use_windows_dithering => xml_to_bool(node, "./TransparentColor/UseWindowsDithering/text()"),
            :alpha_value => xml_to_int(node, "./TransparentColor/AlphaValue/text()"),
            :red => xml_to_int(node, "./TransparentColor/Red/text()"),
            :green => xml_to_int(node, "./TransparentColor/Green/text()"),
            :blue => xml_to_int(node, "./TransparentColor/Blue/text()")
          }
        }
      end

    end
  end
end
