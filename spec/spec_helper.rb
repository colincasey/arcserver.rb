require 'rubygems'
require 'bundler/setup'
require 'pp'
require 'factory_girl'
require 'coveralls'

# require_relative '../lib/arcserver'
require 'arcserver'
require_relative 'shared_context'

RSpec.configure do |config|
  # config.include FactoryGirl::Syntax::Methods
  config.filter_run_excluding broken: true
end

# FactoryGirl.find_definitions
Coveralls.wear!
