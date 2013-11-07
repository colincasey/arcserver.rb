# encoding: utf-8

require 'spec_helper'

describe 'Query' do

  before(:all) do
    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = ArcServer::Graphics::Feature.new({ geometry: { x:998038.6923495262, y:5783734.045721063, spatialReference: { wkid: 102100 }}, attributes: {status:1,req_id:"12345",req_type:"Graffiti Complaint – Private Property",req_date:"30.09.2013",req_time:"14:00",address:"via dei matti 0",district:"Lugano"} })
    results = fs.applyEdits('0', [ f ], [ ], [  ])
  end

  it 'should query for feature' do
    query = ArcServer::REST::Query.new({ where: "district='Lugano'", outFields: "*" })
    feature_set = query.execute("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0")
    feature_set.fieldAliases.should_not be_empty
    feature_set.features.should_not be_empty
    feature_set.features[0].attributes.should have_key(:objectid)
  end

  it 'should query for feature thought a MapServer' do
    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { where: "district='Lugano'", outFields: "*" })
    feature_set.fieldAliases.should_not be_empty
    feature_set.features.should_not be_empty
    feature_set.features[0].attributes.should have_key(:objectid)
  end

  it 'should query by geometry' do

    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { geometryType: 'esriGeometryEnvelope', geometry: { xmin: -180, ymin: -90, xmax: 180, ymax: 90, spatialReference: { wkid: 4326 }}, outFields: "*" })
    feature_set.should_not be_nil
    feature_set.features.size.should be > 0

  end

end
