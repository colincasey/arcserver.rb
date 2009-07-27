# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

class ArcServer::UrlHelperTest < Test::Unit::TestCase
  include ArcServer::UrlHelper

  context "when given a rest service url" do
    setup do
      @url = 'http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer'
    end

    should "be able to recognize it as a rest service" do
      assert rest_service?(@url)
    end

    should "not be mistaken for a soap service" do
      assert !soap_service?(@url)
    end

    should "be able to convert to soap service url" do
      soap_url = to_soap(@url)
      assert soap_service?(soap_url)
      assert !rest_service?(soap_url)
    end
  end

  context "when given a soap service url" do
    setup do
      @url = 'http://sampleserver1.arcgisonline.com/ArcGIS/services/Demographics/ESRI_Census_USA/MapServer'
    end

    should "be able to recognize it as a soap service" do
      assert soap_service?(@url)
    end

    should "not be mistaken for a rest service" do
      assert !rest_service?(@url)
    end

    should "be able to convert to rest service url" do
      rest_url = to_rest(@url)
      assert rest_service?(rest_url)
      assert !soap_service?(rest_url)
    end
  end

  should "recognize a valid map server url" do
    assert map_server?('http://sampleserver1.arcgisonline.com/ArcGIS/services/Demographics/ESRI_Census_USA/MapServer')
  end

  should "recognize an invalid map server url" do
    assert !map_server?('http://not.a.map/server/url')
  end
end
