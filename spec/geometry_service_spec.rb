# encoding: utf-8

require 'spec_helper'

describe 'GeometryService' do

  include_context "shared stuff"

  before(:each) do
    @gs = ArcServer::GeometryService.new("http://sampleserver6.arcgisonline.com/arcgis/rest/services/Utilities/Geometry/GeometryServer")
  end

  it 'projects geometries' do
    projection = @gs.project({ inSR: 102100, outSR: 4326, geometries: { geometryType: "esriGeometryPoint", geometries: [ { x: -8926559.814803278, y: 2974164.2260772274 } ] } })
    projection.should have(1).item
    projection[0].should be_kind_of(ArcServer::Geometry::Point)
    projection[0].x.should eq -80.18865116244909
    projection[0].y.should eq 25.79865037102925
  end

  it 'buffers geometries' do
    buffer = @gs.buffer({ inSR: 4326, outSR: 4326, bufferSR: 102113, distances: 1000, geometries: { geometryType: "esriGeometryPoint", geometries: [ { x: -117, y: 34 } ] } })
    buffer[0].should be_kind_of(ArcServer::Geometry::Polygon)
  end

  it 'buffers geometries with class' do
    buffer = @gs.buffer({ inSR: 4326, outSR: 4326, bufferSR: 102113, distances: 1000, geometries: { geometryType: "esriGeometryPoint", geometries: [ ArcServer::Geometry::Point.new({ x: -117, y: 34 }) ] } })
    buffer[0].should be_kind_of(ArcServer::Geometry::Polygon)
  end

end
