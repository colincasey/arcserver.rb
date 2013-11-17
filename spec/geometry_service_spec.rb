# encoding: utf-8

require 'spec_helper'

describe 'GeometryService' do

  include_context "shared stuff"

  it 'project geometries' do

    gs = ArcServer::GeometryService.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer")
    f1 = ArcServer::Graphics::Feature.new({ geometry: { x: 313.63070000000005, y: -60.33429999999993 } })
    feature_set = ArcServer::Graphics::FeatureSet.new({ geometryType: "esriGeometryPoint", features: [ f1 ] })

    puts feature_set.inspect

    projection = gs.project({ inSR: 4267, outSR: 26912, geometries: feature_set })

    puts projection.inspect

  end

end
