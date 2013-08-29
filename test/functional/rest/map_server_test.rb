# encoding: utf-8
require File.expand_path("../../../test_helper", __FILE__)
require 'yaml'

class ArcServer::REST::FeatureServerTest < Test::Unit::TestCase

  should "be able to add features" do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0/applyEdits")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: -645740.0149531689, y: 4317565.667876012, spatialReference: { wkid: 3857 } }, attributes: { :status => Random.rand(3)+1 } })
    results = fs.applyEdits([ f ], [  ], [  ])
    pp results
  end

  should "be able to update features" do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0/applyEdits")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: -645740.0149531689, y: 4317565.667876012, spatialReference: { wkid: 3857 } }, attributes: { :status => Random.rand(3)+1 } })
    results = fs.applyEdits([  ], [ f ], [  ])
    pp results
  end

end
