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
    feature_set = feature_server.query('0', { geometryType: 'esriGeometryEnvelope', geometry: '{"xmin":997878.8354556253,"ymin":5783588.635939264,"xmax":998147.5593831083,"ymax":5783767.785224252,"spatialReference":{"wkid":102100}}', outFields: "*", inSR: 102100, outSR: 102100 })
    feature_set.features.should_not be_empty

  end

end
