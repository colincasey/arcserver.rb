# encoding: utf-8

require 'spec_helper'

describe 'FeatureServer' do

  it 'should add feature to FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: 997986.50, y: 5783631.06, spatialReference: { wkid: 102100 }}, attributes: {status:1,req_id:"12345",req_type:"Graffiti Complaint – Private Property",req_date:"30.09.2013",req_time:"14:00",address:"via dei matti 1",district:"Lugano"} })

    results = fs.applyEdits('0', [ f ], [ ], [  ])
    results.should have_key(:addResults)
    results[:addResults].should have(1).item
    results[:addResults].each do |r|
      r.should have_key(:objectId)
    end

  end

  it 'should update feature on FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: -645740.0149531689, y: 4317565.667876012, spatialReference: { wkid: 3857 } }, attributes: { objectId: 7994691, :status => Random.rand(3)+1 } })
    results = fs.applyEdits('0', [  ], [ f ], [  ])
    results.should have_key("updateResults")
  end

  it 'should delete features' do

    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { geometryType: 'esriGeometryEnvelope', geometry: '{"xmin":997878.8354556253,"ymin":5783588.635939264,"xmax":998147.5593831083,"ymax":5783767.785224252,"spatialReference":{"wkid":102100}}', outFields: "*", inSR: 102100, outSR: 102100 })

    # pp feature_set.features

    results = feature_server.applyEdits('0', [  ], [  ], feature_set.features.map { |f| f.attributes[:objectid] }.join(','))
    results.should have_key("deleteResults")

  end

end
