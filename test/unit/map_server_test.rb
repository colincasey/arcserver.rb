# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

class ArcServer::MapServerTest < Test::Unit::TestCase
  should "raise an error if the required url is not a map server url" do
    assert_raise(Exception) { ArcServer::MapServer.new('http://not.a.map/server/url') }
  end

  context "verifying delegation of actions to the SOAP service" do
    setup do
      @mock_soap_service = mock
      @map_server = ArcServer::MapServer.new(
        'http://sampleserver1.arcgisonline.com/ArcGIS/services/Demographics/ESRI_Census_USA/MapServer',
        :soap_service => @mock_soap_service
      )
    end

    should "forward get_default_map_name" do
      @mock_soap_service.expects(:get_default_map_name => nil)
      @map_server.get_default_map_name
    end

    should "forward get_legend_info" do
      @mock_soap_service.expects(:get_legend_info => nil)
      @map_server.get_legend_info
    end
  end

  context "verifying delegation of actions to the REST service" do
    setup do
      @mock_rest_service = mock
      @map_server = ArcServer::MapServer.new(
        'http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer',
        :rest_service => @mock_rest_service
      )
    end

    should "forward get_default_map_name" do
      @mock_rest_service.expects(:export => nil)
      @map_server.export
    end
  end
end
