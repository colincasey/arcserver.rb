# encoding: utf-8

module ArcServer
  class ArcServerError < StandardError; end

  class MapServer
    include UrlHelper
    extend  Forwardable

    attr_reader    :soap_service
    def_delegators :soap_service, :get_default_map_name, :get_legend_info, :get_legend_image
    
    attr_reader    :rest_service
    def_delegators :rest_service, :export

    def initialize(url, opts = {})
      raise Exception, "#{url} is not a valid map server url" unless map_server?(url)
      @rest_service = opts[:rest_service] || REST::MapServer.new(to_rest(url))
    end

    # Utility method for generating a legend image
    # (requires optional dependency, RMagick [>= 2.12.0], to be installed)
    #
    # @return [Magick::Image] the legend as an RMagick Image object
    def get_legend_image
       begin
         require 'RMagick' unless Object.const_defined?("Magick")
       rescue LoadError
         raise ArcServerError, "#{self.class}#get_legend_image needs an optional dependency 'RMagick [>= 2.12.0]' to be installed - try `gem install rmagick`"
       end
       Util::LegendImage.new(self).get_image
    end
  end
end