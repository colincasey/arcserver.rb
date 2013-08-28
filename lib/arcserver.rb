# encoding: utf-8
require 'httparty'
require 'forwardable'

relative_load_paths = %w[ arcserver ]
ActiveSupport::Dependencies.autoload_paths += relative_load_paths