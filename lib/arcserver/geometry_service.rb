# encoding: utf-8

module ArcServer
  class GeometryService

    include UrlHelper
    extend  Forwardable

    attr_reader    :rest_service
    def_delegators :rest_service, :url, :project, :buffer

    def initialize(url, opts = {})
      raise Exception, "#{url} is not a valid Geometry Service url" unless geometry_service?(url)
      @rest_service = opts[:rest_service] || REST::GeometryService.new(to_rest(url))
    end

  end
end
