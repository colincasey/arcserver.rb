# encoding: utf-8

module ArcServer
  module SOAP
    # Map services offer access to map and attribute content. Map services can either be cached
    # or dynamic. A map service that fulfills requests with pre-created tiles from a cache instead
    # of dynamically rendering part of the map is called a cached map service. A dynamic map
    # service requires the server to render the map each time a request comes in. Map services
    # using a tile cache can significantly improve performance while delivering maps, while dynamic
    # map services offer more flexibility.
    #
    # Map services offer the following capabilities:
    # * Generate map images for a specified geographic area
    # * Change the description of the map
    # * Control the output map image
    # * Get map legend information
    # * Query map features using attributes or spatial filters
    # * Get information regarding the cache
    # * Get a scale bar
    #
    # WSDL syntax:
    #   http://<Web Server Hostname>/<ArcGIS Instance>/services/<ServiceName>/MapServer?wsdl
    #
    # =Working with map services
    #
    # ==Get information about the map and its layers
    #
    # To access information about a map and its layers use GetServerInfo. GetServerInfo returns MapServerInfo
    # and MapLayerInfo. MapServerInfo contains read-only information describing the default state of a map
    # service, such as the name of the map, the background color or the spatial extent of the map. Read-only
    # layer properties, such as the layer’s name, the layer’s attributes and whether or not the layer has
    # labels associated with it, can be retrieved from MapLayerInfo.
    #
    # If you wish to make changes to the map or to map layers you will need to use MapDescription or
    # LayerDescription. Use MapDescription to access map settings that can be changed such as geographic
    # extent and spatial reference. MapDescription provides access to information on individual layers within
    # the map. LayerDescription provides the ability to change the visibility of a layer, to toggle the visibility
    # of existing labels belonging to the layer and to assign a expression in order to display a specified
    # subset of features.
    #
    # == Exporting a map image
    #
    # To export a map image from a dynamic map service use ExportMapImage. An ImageDescription contains an ImageType
    # and an ImageDisplay. Specifying the image format, such as JPG or PNG, is done using ImageType. Use ImageDisplay to
    # specify the height and width of the image. You can also specify a transparent color using ImageDisplay. The server
    # will restrict the maximum size an image can be. Use GetServiceConfigurationInfo to view the maximum height and width.
    # GetServiceConfigurationInfo contains a set of name-value pairs for properties set for the MapServer Service
    # Configuration Restrictions.
    #
    # ==Information about legend elements
    #
    # You can retrieve legend elements including the symbol image, labels, descriptions and headings. A common use would
    # be to populate a table of contents. To retrieve legend information, use GetLegendInfo and MapServerLegendInfo
    # to retrieve specific information for a particular layer.
    #
    # ==Querying the map
    #
    # Map services offer a number of methods to perform query operations on the map. These include:
    # * Find
    # * Identify
    # * QueryHyperlinks
    # * QueryFeatureCount
    # * QueryFeatureData
    # * QueryFeatureIDs
    # * QueryFeatureCount2
    # * QueryFeatureData2
    # * QueryFeatureIDs2
    #
    # Find returns an array of MapServerFindResults based on a search string. Use MapServerFindResult to access properties
    # of found features, such as the found value, the layer ID, the field name, the geometry of the found feature and a
    # set of name-value pairs for the field names and values of the found features.
    #
    # Identify returns an array of MapServerIdentifyResults based on search shape. Use MapServerIdentifyResult to access
    # properties of identified features. These include: layer ID, name, a set of name-value pairs for the field names and values
    # of the identified object, and the geometry of the identified.
    #
    # QueryFeatureCount and QueryFeatureCount2 both return the number of features that match a query. The difference between
    # the two operations is QueryFeatureCount requires a LayerID as one of the parameters, while QueryFeatureCount2 requires
    # a LayerDescription instead. By passing in a LayerDescription you can query against a specific sub set of the layer by
    # apply a definition expression.
    #
    # QueryFeatureID and QueryFeatureID2 both return an FIDSet. This is the set of feature IDs that match the query criteria.
    # The difference between the two operations is QueryFeatureCount requires a LayerID as one of the parameters, while
    # QueryFeatureCount2 requires a LayerDescription instead. By passing in a LayerDescription you can query against a specific
    # subset of the layer by apply a definition expression.
    #
    # QueryFeatureData and QueryFeatureData2 differ not only in the required parameters, but also in  what is returned.
    # QueryFeatureData returns a RecordSet base on a specific query and includes a LayerID in the method parameters.
    # QueryFeatureData2 returns a QueryResult. A QueryResult includes the URL of the generated query result in the requested
    # format. The result format can be specified by using QueryResultOptions.  The query result can be formatted into a RecordSet
    # or KMZ format (either as a URL to the kmz file or a Mime object). Another property includes GeoTransformation. This is
    # used to specify any needed geographic transformation on the results.
    #
    # The server will restrict the maximum number of records that can be sent. Use GetServiceConfigurationInfo the maximum records
    # that can be returned in a query for this particular map service. GetServiceConfigurationInfo contains a set of name-value
    # pairs for properties set for the MapServer Service Configuration Restrictions. This restriction does not affect
    # QueryFeatureCount, QueryFeatureIds, QueryFeatureCount2 or QueryFeatureIds2.
    #
    # =Working with cached vs. dynamic map services
    #
    # ArcGIS Server map services provide access to two types of visible map content: dynamic and cached.  Dynamic maps
    # are generated on-the-fly per a user request.  Layer visibility, graphics, and other variables can be modified before
    # the dynamic map is generated.  Unfortunately, as the amount of content and complexity in the map increases, so
    # does the amount of time it takes to generate the map.  Alternatively, cached maps consist of pre-generated map
    # tiles available for immediate access.  Since the cost of generating the maps has already been paid, the performance
    # penalty associated with map generation is not a factor.   Working with a map cache requires knowledge of cache
    # properties, such a location and structure, so that you are able to retrieve the appropriate cached image.   In
    # general, a map cache is stored in a nested set of directories which contain image tiles for map extents at specific
    # scale levels, or levels of detail.   The author of the map service determines these levels.  The cached tiles are
    # usually accessible via a public virtual directory or an ArcGIS Server map service tile handler.
    #
    # ==Information about a map cache
    #
    # Use IsFixedScaleMap to determine if a map service is cached. The term fixed scale map service and cached map service are
    # used synonymously.  GetCacheDescriptionInfo returns information on a cached map service in one call including its
    # cache type, its tiling scheme (TileCacheInfo), image information (TileImageInfo) and control information (TileControlInfo).
    #
    # TileCacheInfo contains information on the tiling scheme for the cache. The tiling scheme includes the tiling origin,
    # spatial reference, tile size in pixels and information on the Levels of Detail (LOD) at which the service is cached.
    # LODInfos enumerate a LODInfo object which describes a scale and resolution. Using the tiling scheme information in
    # TileCacheInfo the client can calculate the tiles that cover any rectangular extent in map space and then retrieve
    # tiles either directly from  the virtual directory, or from the tile handler or by making GetMapTile or GetLayerTile
    # requests against the map service.
    #
    # GetMapTile gets the specified tile from a map service that has a single fused cache. GetLayerTile gets the specified
    # tile for a defined layer from a map service that has a multi-layer cache.
    #
    # GetTileImageInfo returns information describing the image format for the cached tiles. TileImageInfo has two main
    # properties Format and Compression quality. Format can have values (PNG8, PNG24, PNG32 and JPEG). If the selected format
    # is JPEG, then the compression quality can have a value from 0 to 100. The value of format must be used in constructing
    # the URL to the tile.
    #
    # GetCacheControlInfo returns cache control information that allows clients to discover information such as if client
    # caching is allowed.
    #
    # =Limitations
    #
    # When generating a map image, map services are not able to perform the following tasks:
    # * Change feature render for an existing layer.
    # * Add a dynamic layer
    # * Change layer draw order
    #
    # Map services do not expose editing capabilities.  They merely provide read-only access to feature and attribute content.
    class MapServer < Handsoap::Service
      protected
      on_create_document do |doc|
        doc.alias "env", "http://schemas.xmlsoap.org/soap/envelope/"
        doc.alias "ns",  "http://www.esri.com/schemas/ArcGIS/9.3"
      end

      def on_before_dispatch
        self.class.endpoint(:uri => @soap_url, :version => 1)
      end

      public
      def initialize(soap_url, protocol_version=2)
        @soap_url = soap_url
      end

      # Get the name of the active map (data frame) in a map service.
      # @return [String] A string representing name of the active map in the map service.
      def get_default_map_name
        response = invoke("ns:GetDefaultMapName")
        node = response.document.xpath('//tns:GetDefaultMapNameResponse/Result', ns).first
        parse_default_map_name_result(node)
      end

      # Returns legend information, such as layer name, group heading, classification labels and symbol swatches,
      # for layers in a map.
      #
      # A map service does not have the ability to generate a single legend image will all legend content.  Instead,
      # the GetLegendInfo() method provides access to legend content which can be used to construct a single consolidated
      # legend.
      #
      # Each MapServerLegendInfo object contains one or more MapServerLegendGroup objects.  Each MapServerLegendGroup object
      # contains one or more MapServerLegendClass objects.  The relationship between value objects and legend content is
      # illustrated in the following diagram.  Note that each MapServerLegendClass contains a classification label and symbol
      # swatch.
      #
      # @param [Hash] args the arguments to send in the SOAP request
      #
      # @option args [String] :map_name (get_default_map_name()) the name of the map (data frame) that will
      #   be used to generate legend info
      #
      # @option args [Array<Integer>] :layer_ids (nil) An array of layer ids for which legend information will
      #   be returned.  If empty or null, all layers will be included.
      #
      # @option args [LegendPatch] :legend_patch (nil) A MapServerLegendPatch used to define symbol swatch properties
      #   for legend classifications.  If empty or null, the default patch properties defined in the map will be used.
      #
      # @option args [String] :image_type ("esriImageReturnMimeData") An ImageType defines the image type and method for
      #   returning the image content for the symbol swatches. Supported image types are 'bmp', 'jpg', 'tif', 'png'/'png8',
      #   'png24', 'emf', 'ps', 'pdf', 'ai', 'gif', and 'svg'/'svgz'.  Image content can be returned as a URL or as a
      #   MIME data stream.
      #
      # @return [Hash] the SOAP response decoded into a Hash
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
        { 'tns' => 'http://www.esri.com/schemas/ArcGIS/9.3' }
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
