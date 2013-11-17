# encoding: utf-8

require 'ostruct'
require 'httparty'
require 'forwardable'
require 'rufus-scheduler'
require 'active_support/all'
require 'active_support/core_ext/hash/indifferent_access'

require_relative 'arcserver/version'
require_relative 'arcserver/url_helper'
require_relative 'arcserver/queryable'
require_relative 'arcserver/identifiable'
require_relative 'arcserver/map_server'
require_relative 'arcserver/geometry_service'
require_relative 'arcserver/feature_server'
require_relative 'arcserver/gp_server'

require_relative 'arcserver/geometry/geometry'

require_relative 'arcserver/graphics/feature_set'
require_relative 'arcserver/graphics/feature'

require_relative 'arcserver/rest/map_server'
require_relative 'arcserver/rest/geometry_service'
require_relative 'arcserver/rest/feature_server'
require_relative 'arcserver/rest/query'
require_relative 'arcserver/rest/identify'
require_relative 'arcserver/rest/gp_server'

module ArcServer

  # relative_load_paths = %w[ arcserver ]
  # ActiveSupport::Dependencies.autoload_paths += relative_load_paths

end

# monkeypath OpenStruct
class OpenStruct
  def as_json(options = nil)
    table.as_json(options)
  end
end
