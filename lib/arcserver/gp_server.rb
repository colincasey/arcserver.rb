# encoding: utf-8

module ArcServer
  class ArcServerError < StandardError; end

  class GPServer

    include UrlHelper
    extend  Forwardable

    attr_reader    :rest_service
    def_delegators :rest_service, :url, :submitJob

    def initialize(url, opts = {})
      raise Exception, "#{url} is not a valid map server url" unless gp_server?(url)
      @rest_service = opts[:rest_service] || REST::GPServer.new(to_rest(url))
    end

  end
end
