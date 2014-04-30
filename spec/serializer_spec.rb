# encoding: utf-8

require 'spec_helper'

describe 'Serialize' do

  it 'Serialize a feature to json' do

    attrs = {
      status:    "1",
      req_id:    "12345",
      req_type:  "Graffiti Complaint – Private Property",
      req_date:  "30.09.2013",
      req_time:  "14:00",
      address:   "via dei matti 1",
      district:  "Lugano"
    }

    geometry = { x: 1, y: 2 }
    f = ArcServer::Graphics::Feature.new(geometry: geometry, attributes: attrs)

    json = f.to_json
    json.should include "\"geometry\":{\"x\":1,\"y\":2}"
    json.should include "\"attributes\":{\"status\":\"1\",\"req_id\":\"12345\",\"req_type\":\"Graffiti Complaint \\u2013 Private Property\",\"req_date\":\"30.09.2013\",\"req_time\":\"14:00\",\"address\":\"via dei matti 1\",\"district\":\"Lugano\"}"

  end

  it 'serialize a point' do

    geometry = ArcServer::Geometry::Geometry.create( x: 997986.50, y: 5783631.06, spatialReference: { wkid: 102100 } )
    geometry.geometryType.should eq 'esriGeometryPoint'

    f = ArcServer::Graphics::Feature.new(geometry: geometry, attributes: {})
    json = f.to_json
    json.should include "\"geometry\":{\"x\":997986.5,\"y\":5783631.06,\"spatialReference\":{\"wkid\":102100}}"

  end

  it 'serialize a multipoint' do

    json = '{ "points" : [[-97.06138,32.837,35.0], [-97.06133,32.836,35.1], [-97.06124,32.834,35.2]], "spatialReference" : {"wkid" : 4326} }'
    geometry = ArcServer::Geometry::Geometry.create(json)
    geometry.geometryType.should eq 'esriGeometryMultipoint'

    f = ArcServer::Graphics::Feature.new(geometry: geometry, attributes: {})
    json = f.to_json
    json.should include "\"geometry\":{\"points\":[[-97.06138,32.837,35.0]"

  end

  it 'serialize a polyline' do

    json = '{ "paths" : [[[-97.06138,32.837],[-97.06133,32.836],[-97.06124,32.834],[-97.06127,32.832]], [[-97.06326,32.759],[-97.06298,32.755]]], "spatialReference" : {"wkid" : 4326} }'
    geometry = ArcServer::Geometry::Geometry.create(json)
    geometry.geometryType.should eq 'esriGeometryPolyline'

    f = ArcServer::Graphics::Feature.new(geometry: geometry, attributes: {})
    json = f.to_json
    json.should include "\"geometry\":{\"paths\":[[[-97.06138,32.837],[-97.06133,32.836]"

  end

  it 'serialize a polygon' do

    geometry = ArcServer::Geometry::Geometry.create('{"rings" : [[[-97.06138,32.837],[-97.06133,32.836],[-97.06124,32.834],[-97.06127,32.832],[-97.06138,32.837]],[[-97.06326,32.759],[-97.06298,32.755],[-97.06153,32.749],[-97.06326,32.759]]],"spatialReference" : {"wkid" : 4326}}')
    geometry.geometryType.should eq 'esriGeometryPolygon'
    f = ArcServer::Graphics::Feature.new(geometry: geometry, attributes: {})
    json = f.to_json
    json.should include "\"geometry\":{\"rings\""
    json.should include "[[[-97.06138,32.837],[-97.06133,32.836]"

  end

  it 'serialize an envelope' do

    json = '{"xmin" : -109.55, "ymin" : 25.76, "xmax" : -86.39, "ymax" : 49.94, "spatialReference" : {"wkid" : 4326}}'
    geometry = ArcServer::Geometry::Geometry.create(json)
    geometry.geometryType.should eq 'esriGeometryEnvelope'

    f = ArcServer::Graphics::Feature.new(geometry: geometry, attributes: {})
    json = f.to_json
    json.should include "\"xmin\":-109.55,\"ymin\":25.76,\"xmax\":-86.39,\"ymax\":49.94,\"spatialReference\":{\"wkid\":4326}}"

  end

end
