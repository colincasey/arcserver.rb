# encoding: utf-8

require 'spec_helper'

describe 'FeatureServer' do

  include_context "shared stuff"

  it 'should add feature to FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: 997986.50, y: 5783631.06, spatialReference: { wkid: 102100 }}, attributes: {status:1,req_id:"12345",req_type:"Graffiti Complaint – Private Property",req_date:"30.09.2013",req_time:"14:00",address:"via dei matti 1",district:"Lugano"} })

    results = fs.applyEdits('0', [ f ], [ ], [  ])
    results.should have_key(:addResults)
    results[:addResults].should have(1).item
    results[:addResults].each do |r|
      r.should have_key(:objectId)
      r.should have_key(:success)
      r[:success].should be true
    end

  end

  it 'should update feature on FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = query_for_random_feature
    f.attributes[:address] = "The Avengers Tower"

    puts f.to_json

    results = fs.applyEdits('0', [  ], [ f ], [  ])
    results.should have_key(:updateResults)
    results[:updateResults].each do |r|
      r.should have_key(:objectId)
      r.should have_key(:success)
      r[:success].should be true
    end
  end

  it 'should delete features' do

    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { where: 'status=1', outFields: "*", inSR: 102100, outSR: 102100 })

    deletes = feature_set.features[1..3].map { |f| f.attributes[:objectid] }.join(',')
    results = feature_server.applyEdits('0', [  ], [  ], deletes)
    results.should have_key(:deleteResults)

  end

end
