# encoding: utf-8

require 'ostruct'
require 'httparty'
require 'forwardable'
require 'rufus-scheduler'
require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/to_json'

require 'arcserver/version'
require 'arcserver/url_helper'
require 'arcserver/Identifiable'
require 'arcserver/Queryable'
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

  def initialize( hash=nil )
    @table = {}
    @hash_table = {}

    if hash
      hash.each do |k, v|
        @table[k.to_sym] = (v.is_a?(Hash) ? OpenStruct.new(v) : v)
        @hash_table[k.to_sym] = v
        new_ostruct_member(k)
      end
    end
  end

  def as_json(options = nil)
    table.as_json(options)
  end

end
