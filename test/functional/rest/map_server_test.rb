# encoding: utf-8
require File.expand_path("../../../test_helper", __FILE__)
require 'yaml'

class ArcServer::REST::FeatureServerTest < Test::Unit::TestCase

  should "be able to update features" do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0/applyEdits")
    f = ArcServer::Graphics::Feature.new({ attributes: { :objectid => 7988410, :status => Random.rand(3)+1 } })
    fs.applyEdits([], [ f ], [])

  end

end
