# encoding: utf-8

require 'spec_helper'

describe 'FeatureServer' do

  it 'should add feature to FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: 997986.50, y: 5783631.06, spatialReference: { wkid: 102100 }}, attributes: {status:1,req_id:"12345",req_type:"Graffiti Complaint – Private Property",req_date:"30.09.2013",req_time:"14:00",address:"via dei matti 1",district:"Lugano"} })

    # f = FactoryGirl.build(:feature)

    results = fs.applyEdits([ f ], [ ], [  ])
    results.should have_key(:addResults)
    results[:addResults].should have(1).item
    results[:addResults].each do |r|
      r.should have_key(:objectId)
    end

  end

  it 'should update feature on FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: -645740.0149531689, y: 4317565.667876012, spatialReference: { wkid: 3857 } }, attributes: { objectId: 7994691, :status => Random.rand(3)+1 } })
    results = fs.applyEdits([  ], [ f ], [  ])
    results.should have_key("updateResults")
  end

end