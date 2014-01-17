# encoding: utf-8

require 'ostruct'
require 'httparty'
require 'forwardable'
require 'rufus-scheduler'
require 'active_support/all'
# require 'active_support/core_ext/hash/indifferent_access'

require 'arcserver/version'
require 'arcserver/url_helper'
require 'arcserver/identifiable'
require 'arcserver/queryable'
require 'arcserver/map_server'
require 'arcserver/geometry_service'
require 'arcserver/feature_server'
require 'arcserver/gp_server'
require 'arcserver/geometry/geometry'
require 'arcserver/graphics/feature_set'
require 'arcserver/graphics/feature'
require 'arcserver/rest/map_server'
require 'arcserver/rest/geometry_service'
require 'arcserver/rest/feature_server'
require 'arcserver/rest/query'
require 'arcserver/rest/identify'
require 'arcserver/rest/gp_server'

# monkeypath OpenStruct
class OpenStruct
  def as_json(options = nil)
    table.as_json(options)
  end
end
