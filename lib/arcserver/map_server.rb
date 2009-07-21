# encoding: utf-8
require 'arcserver/rest/map_server'
require 'arcserver/soap/map_server'
require 'forwardable'

module ArcServer
  class MapServer
    include UrlHelper
    extend  Forwardable

    attr_reader   :soap_service
    def_delegator :soap_service, :get_default_map_name
    
    attr_reader   :rest_service
    def_delegator :rest_service, :export_map

    def initialize(opts = {})
      @soap_service = opts[:soap_service] || SOAP::MapServer.new
      @rest_service = opts[:rest_service] || REST::MapServer.new
    end
  end
end