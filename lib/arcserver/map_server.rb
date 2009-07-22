# encoding: utf-8
require 'arcserver/rest/map_server'
require 'arcserver/soap/map_server'
require 'forwardable'

module ArcServer
  class MapServer
    include UrlHelper
    extend  Forwardable

    attr_reader    :soap_service
    def_delegators :soap_service, :get_default_map_name, :get_legend_info
    
    attr_reader    :rest_service
    def_delegators :rest_service, :export

    def initialize(url, opts = {})
      @soap_service = opts[:soap_service] || SOAP::MapServer.new(to_rest(url))
      @rest_service = opts[:rest_service] || REST::MapServer.new(to_soap(url))
    end
  end
end