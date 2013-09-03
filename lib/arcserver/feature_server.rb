# encoding: utf-8

module ArcServer
  class FeatureServer

    include UrlHelper
    include Queryable
    extend  Forwardable

    attr_reader    :rest_service
    def_delegators :rest_service, :url, :applyEdits

    def initialize(url, opts = {})
      raise Exception, "#{url} is not a valid feature server url" unless feature_server?(url)
      @rest_service = opts[:rest_service] || REST::FeatureServer.new(to_rest(url))
    end

  end
end
