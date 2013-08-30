$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rspec/core/rake_task'
require 'arcserver/version'
require "bundler/gem_tasks"

task :default => :spec

RSpec::Core::RakeTask.new('spec')
