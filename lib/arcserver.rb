# encoding: utf-8

require 'httparty'
require 'forwardable'
require 'active_support/all'
require 'active_record'
require 'active_support/core_ext/hash/indifferent_access'

require 'arcserver/version'
require 'arcserver/url_helper'
require 'arcserver/queryable'
require 'arcserver/identifiable'
require 'arcserver/map_server'
require 'arcserver/feature_server'

require 'arcserver/graphics/feature_set'
require 'arcserver/graphics/feature'

require 'arcserver/rest/map_server'
require 'arcserver/rest/feature_server'
require 'arcserver/rest/query'
require 'arcserver/rest/identify'

# relative_load_paths = %w[ arcserver ]
# ActiveSupport::Dependencies.autoload_paths += relative_load_paths
