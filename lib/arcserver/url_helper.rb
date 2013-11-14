# encoding: utf-8

module ArcServer
  module UrlHelper

    def rest_service?(url)
      url.to_s.match(/ArcGIS\/rest\/.*/)
    end

    def map_server?(url)
      url.to_s.match(/\/MapServer$/)
    end

    def feature_server?(url)
      url.to_s.match(/\/FeatureServer/)
    end

    def gp_server?(url)
      url.to_s.match(/\/GPServer/)
    end

    def to_rest(url)
      rest_service?(url) ? url : url.sub('/ArcGIS/', '/ArcGIS/rest/')
    end

  end
end
