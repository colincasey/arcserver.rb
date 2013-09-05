require 'rubygems'
require 'bundler/setup'
require 'pp'
require 'factory_girl'

require_relative '../lib/arcserver'
require_relative 'shared_context'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# FactoryGirl.find_definitions
