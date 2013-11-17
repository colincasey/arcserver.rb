# encoding: utf-8

require 'spec_helper'

describe 'GeometryService' do

  include_context "shared stuff"

  it 'project geometries' do

    gs = ArcServer::GeometryService.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer")
    projection = gs.project({ inSR: 4267, outSR: 26912, geometries: { geometryType: "esriGeometryPoint", geometries: [ { x: 313.63070000000005, y: -60.33429999999993 } ] } })
    puts projection.inspect

  end

end
