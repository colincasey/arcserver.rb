# encoding: utf-8
require 'httparty'
require 'forwardable'
require 'active_support/all'
require 'active_record'

require 'arcserver/version'
require 'arcserver/url_helper'
require 'arcserver/map_server'

require 'arcserver/graphics/feature_set'
require 'arcserver/graphics/feature'

require 'arcserver/rest/map_server'
require 'arcserver/rest/query'

# relative_load_paths = %w[ arcserver ]
# ActiveSupport::Dependencies.autoload_paths += relative_load_paths