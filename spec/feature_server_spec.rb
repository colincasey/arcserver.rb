require 'spec_helper'

describe 'FeatureServer' do

  it 'should add feature to FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0/applyEdits")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: -645740.0149531689, y: 4317565.667876012, spatialReference: { wkid: 3857 } }, attributes: { status: Random.rand(3)+1 } })
    results = fs.applyEdits([ f ], [ ], [  ])
    # {"addResults"=>[{"objectId"=>7994691, "globalId"=>nil, "success"=>true}], "updateResults"=>[], "deleteResults"=>[]}
    results.should have_key("addResults")

  end

  it 'should update feature on FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer/0/applyEdits")
    f = ArcServer::Graphics::Feature.new({ geometry: { x: -645740.0149531689, y: 4317565.667876012, spatialReference: { wkid: 3857 } }, attributes: { objectId: 7994691, :status => Random.rand(3)+1 } })
    results = fs.applyEdits([  ], [ f ], [  ])
    # {"addResults"=>[{"objectId"=>7994691, "globalId"=>nil, "success"=>true}], "updateResults"=>[], "deleteResults"=>[]}
    results.should have_key("updateResults")

  end

end