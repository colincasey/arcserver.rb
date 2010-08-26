# encoding: utf-8

module ArcServer
  module REST
    class MapServer
      attr_reader :url

      def initialize(url)
        @url = url
      end

      # The export operation is performed on a map service resource. The result
      # of this operation is a map image resource. This resource provides information
      # about the exported map image such as its URL, its width and height, extent
      # and scale.
      #
      # Apart from the usual response formats of html and json, users can also
      # request a format called image while performing this operation. When users
      # perform an export with the format of image, the server responds by directly
      # streaming the image bytes to the client. One must note that with this
      # approach you don't get any information associated with the exported map
      # other than the actual image.
      #
      # Note that the extent displayed in the exported map image may not exactly
      # match the extent sent in the bbox parameter when the aspect ratio of the
      # image size does not match the aspect ratio of the bbox.  The aspect ratio
      # is the height divided by the width.  In these cases the extent is re-sized
      # to prevent map images from appearing stretched.  The exported map’s extent
      # is sent along with the json and html responses and may be used in client
      # side calculations. So it is important that the client-side code update its
      # extent based on the response.
      #
      # f	Description: The response format. The default response format is html. If the format is image, the image bytes are directly streamed to the client.
      #
      #Values: html | json | image | kmz
      #bbox	Required
      #Description: The extent (bounding box) of the exported image. Unless the bboxSR parameter has been specified, the bbox is assumed to be in the spatial reference of the map.
      #
      #Syntax: <xmin>, <ymin>, <xmax>, <ymax>
      #
      #Example: bbox=-104,35.6,-94.32,41
      #
      #
      #The bboxcoordinates should always use a period as the decimal separator even in countries where traditionally a comma is used.
      #size	Description: The size (width * height) of the exported image in pixels. If the size is not specified, an image with a default size of 400 * 400 will be exported.
      #
      #Syntax: <width>, <height>
      #
      #Example: size=600,550
      #dpi	Description: The device resolution of the exported image (dots per inch). If the dpi is not specified, an image with a default DPI of 96 will be exported.
      #
      #Example: dpi=200
      #imageSR	Description: The well-known ID of the spatial reference of the exported image. If the imageSR is not specified, the image will be exported in the spatial reference of the map.
      #bboxSR	Description: The well-known ID of the spatial reference of the bbox. If the bboxSR is not specified, the bbox is assumed to be in the spatial reference of the map.
      #format	Description: The format of the exported image. The default format is png.
      #
      #Values: png | png8 | png24 | jpg | pdf | bmp | gif | svg | png32
      #
      #Note: Support for the png32 format was added at 9.3.1. This format is only available for map services whose supportedImageFormatTypes property includes PNG32
      #layerDefs	Description: Allows you to filter the features of individual layers in the exported map by specifying definition expressions for those layers.
      #
      #Syntax: layerId1:layerDef1;layerId2:layerDef2
      #where layerId1, layerId2 are the layer ids returned by the map service resource
      #
      #Example: 0:POP2000 > 1000000;5:AREA > 100000
      #layers	Description: Determines which layers appear on the exported map. There are four ways to specify which layers are shown:
      #
      #show: Only the layers specified in this list will be exported.
      #hide: All layers except those specified in this list will be exported.
      #include: In addition to the layers exported by default, the layers specified in this list will be exported.
      #exclude: The layers exported by default excluding those specified in this list will be exported.
      #
      #Syntax: [show | hide | include | exclude]:layerId1,layerId2
      #where layerId1, layerId2are the layer ids returned by the map service resource
      #
      #Example: layers=show:2,4,7
      #transparent	Description: If true, the image will be exported with the background color of the map set as its transparent color. The default is false. Only the png and gif formats support transparency.  Internet Explorer 6 does not display transparency correctly for png24 image formats.
      #
      #Values: true | false
      def export(opts = {})
        query = {
          :bbox        => opts[:bbox],
          :f           => opts[:f]           || :image,
          :format      => opts[:format]      || :png24,
          :transparent => opts[:transparent] || true,
          :size        => opts[:size],
          :dpi         => opts[:dpi]
        }
        HTTParty.get("#{url}/export", :query => query)
      end
    end
  end
end