# encoding: utf-8

module ArcServer
  module REST
    # Map services offer access to map and layer content. Map services can either
    # be cached or dynamic. A map service that fulfills requests with pre-created
    # tiles from a cache instead of dynamically rendering part of the map is called
    # a cached map service. A dynamic map service requires the server to render
    # the map each time a request comes in. Map services using a tile cache can
    # significantly improve performance while delivering maps, while dynamic map
    # services offer more flexibility. Map services should always be published as
    # pooled services.
    #
    # The REST API map service resource represents a map service. This resource
    # works only with the default data frame of your published map document. This
    # resource provides basic information about the map, including the layers that
    # it contains, whether the map is cached or not, its spatial reference, initial
    # and full extents, map units, and copyright text. It also provides some metadata
    # associated with the service such as its service description, its author, and
    # keywords. If the map is cached, then additional information about its tiling
    # scheme such as the origin of the cached tiles, the levels of detail, and tile
    # size is included. Note that multi-layer caches are only accessible in REST
    # via export, and these requests are treated as a dynamic map service. Tile
    # access is not supported in REST for multi-layer caches.
    #
    # The map service resource supports several operations:
    #
    # * Export map - Used to export a map image from a dynamic map service. The
    #   resulting map can be used for display and be in a different projection from
    #   the original data source. When generating a map image, map services are
    #   not able to change feature rendering for an existing layer, add a dynamic
    #   layer, or change the layer draw order.
    #
    # * Identify - Returns information about features in one or more layers based
    #   on where a user clicks on the map.
    #
    # * Find - Returns information about features in one or more fields in one or
    #   more layers based on a key word.
    #
    # * Generate KML - Generates a KML document wrapped in a kmz file. The document
    #   contains a network link to the KML service endpoint with specified properties
    #   and parameters. This operation is valid on services that have not been restricted
    #   by using a token service.
    #
    # * Query on a Layer - Returns a subset of features in a layer based on query
    #   criteria.
    #
    # * Map services do not expose editing capabilities. They provide read-only
    #   access to feature and attribute content.
    class MapServer
      # The REST url of a map service 
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
      # @param [Hash] params the query parameters to pass to the export operation
      # 
      # @option params [String, Symbol] :f (:image) The response format. The default response
      #   format is html. If the format is image, the image bytes are directly streamed
      #   to the client.
      #
      #     # Values: html | json | image | kmz | pjson (pretty json)
      #     # Examples:
      #     :f => :json
      #     :f => 'kmz'
      #
      # @option params [required, String, Array] :bbox The extent (bounding box) of
      #   the exported image. Unless the bboxSR parameter has been specified, the
      #   bbox is assumed to be in the spatial reference of the map.
      #
      #     # Syntax: <xmin>, <ymin>, <xmax>, <ymax>
      #     # Examples:
      #     :bbox => "-104,35.6,-94.32,41"
      #     :bbox => [-104,35.6,-94.32,41]
      #
      #     # Note: The bboxcoordinates should always use a period as the decimal separator
      #     # even in countries where traditionally a comma is used.
      #
      # @option params [String, Array] :size ([400, 400]) The size (width * height) of the exported
      #   image in pixels. If the size is not specified, an image with a default
      #   size of 400 * 400 will be exported.
      #
      #     # Syntax: <width>, <height>
      #     # Examples:
      #     :size => "600,550"
      #     :size => [600,550]
      #
      # @option params [Integer] :dpi (96) The device resolution of the exported
      #   image (dots per inch).
      #
      #     # Example:
      #     :dpi => 300
      #
      # @option params [Integer] :imageSR	The well-known ID of the spatial reference
      #   of the exported image. If the imageSR is not specified, the image will
      #   be exported in the spatial reference of the map.
      #
      #     # Example:
      #     :imageSR => 4326
      #
      # @option params [Integer] :bboxSR The well-known ID of the spatial reference
      #   of the bbox. If the bboxSR is not specified, the bbox is assumed to be
      #   in the spatial reference of the map.
      #
      #     # Example:
      #     :bboxSR => 4326
      #
      # @option params [String, Symbol] :format (:png) The format of the exported
      #   image.
      #
      #     # Values: png | png8 | png24 | jpg | pdf | bmp | gif | svg | png32
      #     # Examples:
      #     :format => :png32
      #     :format => 'jpg'
      #
      #     # Note: Support for the png32 format was added at 9.3.1. This format is only
      #     # available for map services whose supportedImageFormatTypes property includes PNG32
      #
      # @option params [String] :layerDefs	Allows you to filter the features of
      #   individual layers in the exported map by specifying definition expressions
      #   for those layers.
      #
      #     # Syntax: layerId1:layerDef1;layerId2:layerDef2
      #     # (where layerId1, layerId2 are the layer ids returned by the map service resource)
      #     # Example:
      #     :layersDefs => "0:POP2000 > 1000000;5:AREA > 100000"
      #     :layersDefs => { 0 => "POP2000 > 1000000", 1 => "AREA > 100000" }
      #
      # @option params [String, Hash<Symbol, Array>] layers	Determines which layers appear on the exported
      #   map. There are four ways to specify which layers are shown:
      #
      #   * show: Only the layers specified in this list will be exported.
      #   * hide: All layers except those specified in this list will be exported.
      #   * include: In addition to the layers exported by default, the layers specified in this list will be exported.
      #   * exclude: The layers exported by default excluding those specified in this list will be exported.
      #
      #       # Syntax: [show | hide | include | exclude]:layerId1,layerId2
      #       # where layerId1, layerId2are the layer ids returned by the map service resource      
      #       # Examples:
      #       :layers => "show:2,4,7"
      #       :layers => { :show => [2,4,7] }
      #
      # @option params [true, false] transparent (false)	If true, the image will be exported
      #   with the background color of the map set as its transparent color. The default
      #   is false. Only the png and gif formats support transparency.  Internet
      #   Explorer 6 does not display transparency correctly for png24 image formats.
      #
      # @example
      #   # create a map service
      #   map_service = MapServer.new("http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer")
      #
      #   # Export a map
      #   map_service.export(:bbox => "-127.8,15.4,-63.5,60.5")
      #
      #   # Export a map and change imageSR to 102004 (USA_Contiguous_Lambert_Conformal_Conic projection)
      #   map_service.export(:bbox => "-127.8,15.4,-63.5,60.5", :imageSR => 102004, :f => "html")
      #
      #   # Export a map, change imageSR to 102004 (USA_Contiguous_Lambert_Conformal_Conic projection),
      #   # set image size to a width and height of 800x600, format to gif, and transparent to true.
      #   map_service.export(:bbox => "-115.8,30.4,-85.5,50.5", :size => "800,600", :imageSR => 102004, :format => "gif", :transparent => false, :f => "html")
      #
      #   # Export the same map as above but change the output format to pretty json (f=pjson).
      #   map_service.export(:bbox => "-115.8,30.4,-85.5,50.5", :size => "800,600", :imageSR => 102004, :format => "gif", :transparent => false, :f => "pjson")
      #
      # @example
      #   JSON Response Syntax:
      #   {
      #     "href" : "<href>",
      #     "width" : <width>,
      #     "height" : <height>,
      #     "extent" : {<envelope>},
      #     "scale" : <scale>
      #   }
      #
      #   JSON Response Example:
      #   {
      #     "href" : "http://atlantic/arcgisoutput/_ags_map42ef5eae899942a9b564138e184a55c9.png",
      #     "width" : 400,
      #     "height" : 400,
      #     "extent" : {
      #       "xmin" : -109.55,
      #       "ymin" : 25.76,
      #       "xmax" : -86.39,
      #       "ymax" : 49.94,
      #       "spatialReference" : { "wkid" : 4326 }
      #     },
      #     "scale" : 2.53E7
      #   }
      #
      # @return [HTTParty::Response] the HTTP response
      def export(params = {})
        params = {
          :bbox        => params[:bbox],
          :f           => params[:f]           || :image,
          :format      => params[:format]      || :png24,
          :transparent => params[:transparent] || true,
          :size        => params[:size],
          :dpi         => params[:dpi]
        }
        HTTParty.get("#{url}/export", :query => params)
      end
    end
  end
end