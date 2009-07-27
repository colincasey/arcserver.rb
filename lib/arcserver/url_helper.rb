# encoding: utf-8

module ArcServer
  module UrlHelper
    def rest_service?(url)
      url.to_s.match(/ArcGIS\/rest\/.*/)
    end

    def soap_service?(url)
      url.to_s.match(/ArcGIS\/(?!rest\/).*/)
    end

    def map_server?(url)
      url.to_s.match(/\/MapServer$/)
    end

    def to_rest(url)
      rest_service?(url) ? url : url.sub('/ArcGIS/', '/ArcGIS/rest/')
    end

    def to_soap(url)
      soap_service?(url) ? url : url.sub('/ArcGIS/rest/', '/ArcGIS/')
    end
  end
end