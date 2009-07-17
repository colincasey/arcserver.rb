# -*- coding: utf-8 -*-
require 'handsoap'

module ArcServer
  
end
class Example::FooService < Handsoap::Service
  endpoint EXAMPLE_SERVICE_ENDPOINT
  on_create_document do |doc|
    doc.alias 'wsdl', "http://example.org/ws/spec"
  end
  # public methods
  # todo

  private
  # helpers
  # todo
end
