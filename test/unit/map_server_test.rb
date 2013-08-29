# encoding: utf-8
require File.expand_path("../../test_helper", __FILE__)

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

  context "verifying delegation of actions to the rest service" do
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

  context "verify delegation of legend image creation to ArcServer::Util::LegendImage" do
    setup do
      @map_server = ArcServer::MapServer.new('http://sampleserver1.arcgisonline.com/ArcGIS/services/Demographics/ESRI_Census_USA/MapServer')
    end

    should "fail if optional dependency RMagick is not installed" do
      Object.expects(:const_defined?).with("Magick").returns(false)
      @map_server.expects(:require).with('RMagick').raises(LoadError)
      assert_raise(ArcServer::ArcServerError) { @map_server.get_legend_image }
    end

    should "forward get_legend_image to LegendImage" do
      mock_legend_image = mock { expects(:get_image) }
      ArcServer::Util::LegendImage.expects(:new).with(@map_server).returns(mock_legend_image)
      @map_server.get_legend_image
    end
  end  
end
