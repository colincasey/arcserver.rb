# encoding: utf-8

require 'spec_helper'

describe 'Identify' do

  it 'should identify feature in MapServer' do
    map_server = ArcServer::MapServer.new("http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer")
    results = map_server.identify({ geometryType: "esriGeometryPoint", geometry: "-120,40", tolerance: "10", mapExtent: "-119,38,-121,41", imageDisplay: "400,300,96" })

    results.each do |result|
      ["Nevada", "California", "Washoe", "Lassen", "Plumas"].should include result.value
      result.feature.attributes.should_not be_empty
      result.feature.geometry.should_not be_empty
      result.feature.attributes.should have_key(:OBJECTID)
    end

  end

end
