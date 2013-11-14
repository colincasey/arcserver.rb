# encoding: utf-8

require 'spec_helper'

describe 'Geometry' do

  include_context "shared stuff"

  it 'creates feature with Geometry class' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = query_for_random_feature
    f.geometry.should be_kind_of(ArcServer::Geometry::Point)

    g = f.geometry
    g.should respond_to(:extent)
    g.should respond_to(:x)
    g.should respond_to(:y)

  end

  it 'parse Point Geometry as JSON' do
    json_geometry = '{"x" : -118.15, "y" : 33.80}'
    geometry = ArcServer::Geometry::Geometry.fromJSON json_geometry
    geometry.should be_kind_of(ArcServer::Geometry::Point)

    json_geometry = '{ "x" : -118.15, "y" : 33.80, "spatialReference" : {"wkid" : 4326} }'
    geometry = ArcServer::Geometry::Geometry.fromJSON json_geometry
    geometry.should be_kind_of(ArcServer::Geometry::Point)

  end

  it 'parse Polyline Geometry as JSON' do
    json_geometry = '{ "paths" : [ [ [-97.06138,32.837], [-97.06133,32.836], [-97.06124,32.834], [-97.06127,32.832] ], [ [-97.06326,32.759], [-97.06298,32.755] ] ],"spatialReference" : {"wkid" : 4326 } }'

    geometry = ArcServer::Geometry::Geometry.fromJSON json_geometry
    geometry.should be_kind_of(ArcServer::Geometry::Polyline)
  end

  it 'parse Polygon Geometry as JSON' do
    json_geometry = '{ "rings" : [ [ [-97.06138,32.837], [-97.06133,32.836], [-97.06124,32.834], [-97.06127,32.832], [-97.06138,32.837] ], [ [-97.06326,32.759], [-97.06298,32.755], [-97.06153,32.749], [-97.06326,32.759] ] ], "spatialReference" : {"wkid" : 4326} }'

    geometry = ArcServer::Geometry::Geometry.fromJSON json_geometry
    geometry.should be_kind_of(ArcServer::Geometry::Polygon)
  end

  it 'parse Multipoint Geometry as JSON' do
    json_geometry = '{ "points" : [ [-97.06138,32.837], [-97.06133,32.836], [-97.06124,32.834], [-97.06127,32.832] ], "spatialReference" : {"wkid" : 4326}}'

    geometry = ArcServer::Geometry::Geometry.fromJSON json_geometry
    geometry.should be_kind_of(ArcServer::Geometry::Multipoint)
  end

  it 'parse Envelope Geometry as JSON' do
    json_geometry = '{ "xmin" : -109.55, "ymin" : 25.76, "xmax" : -86.39, "ymax" : 49.94, "spatialReference" : {"wkid" : 4326} }'

    geometry = ArcServer::Geometry::Geometry.fromJSON json_geometry
    geometry.should be_kind_of(ArcServer::Geometry::Envelope)
  end

end
