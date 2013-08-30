# encoding: utf-8

require 'spec_helper'

describe 'Query' do

  before(:all) do
    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0/applyEdits")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: 997986.5006082746, y: 5783631.06234916, spatialReference: { wkid: 102100 }}, attributes: {status:1,req_id:"12345",req_type:"Graffiti Complaint – Private Property",req_date:"30.09.2013",req_time:"14:00",address:"via dei matti 0",district:"Lugano"} })
    results = fs.applyEdits([ f ], [ ], [  ])
  end

  it 'should query for feature' do
    query = ArcServer::REST::Query.new({ where: "district='Lugano'", outFields: "*" })
    feature_set = query.execute("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0")
    feature_set.features.should_not be_empty
    feature_set.features[0].attributes.should have_key(:objectid)
  end

end
