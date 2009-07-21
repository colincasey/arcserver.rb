# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

class ArcServer::MapServerTest < Test::Unit::TestCase
  context "verifying delegation to the soap service" do
    setup do
      @mock_soap_service = mock
      @map_server = ArcServer::MapServer.new(:soap_service => @mock_soap_service)
    end

    should "forward get_default_map_name" do
      @mock_soap_service.expects(:get_default_map_name => 'default')
      @map_server.get_default_map_name
    end
  end
end
