# encoding: utf-8

require 'spec_helper'

describe 'Custom Specs' do

  it "should query with a point" do

    map = ArcServer::MapServer.new("http://srvgists006.lugano.ch:6080/arcgis/rest/services/Territorio/OggettiLugano/MapServer")
    feature_set = map.query('0', { where: "ID_SCHEDA=7", outFields: "*" })

    oggetto = feature_set.features[0] # la prima feature del featureSet

    basemap = ArcServer::MapServer.new("http://srvgispr001.lugano.ch:8399/arcgis/rest/services/Base/BaseMap2Dyn/MapServer")
    fs = basemap.query('3', { geometryType: feature_set.geometryType, geometry: oggetto.geometry, outFields: "*", inSR: 21781, returnGeometry: true })
    particella = fs.features[0]

    # pr = ArcServer::MapServer.new("http://srvgispr001.lugano.ch:8399/arcgis/rest/services/PR/PR3Dyn/MapServer")
    # varianti = pr.query('0', { outFields: "TIPO", inSR: 21781, geometryType: fs.geometryType, geometry: particella.geometry, returnGeometry: false })

    # varianti.features.each do |v|
    #   puts v.attributes['TIPO']
    # end

    map_server = ArcServer::MapServer.new("http://srvgispr001.lugano.ch:8399/arcgis/rest/services/PR/PR3Dyn/MapServer")
    results = map_server.identify({ geometryType: fs.geometryType, geometry: particella.geometry, tolerance: "10", mapExtent: "713286.65,88660.024,727694.27,108826.21", imageDisplay: "400,300,96", returnGeometry: false })

    results.each do |i|
      puts i
      # puts "Layer ID: #{i.layerId}"
      # puts i.feature.attributes
    end

    # puts fs.features[0].geometry

    fs_gp = ArcServer::Graphics::FeatureSet.new({ features: [ fs.features[0] ] })
    # puts fs_gp.to_json

    gp = ArcServer::GPServer.new("http://srvgispr001.lugano.ch:8399/arcgis/rest/services/GisWeb/GPServer/GWClip")
    params = { Feature_Set: fs_gp.to_json }

    gp.submitJob(params) do |results|
      results["zone_clipped"].features.each do |f|
        puts f.attributes['ZONA'] if f.attributes['Shape_Area'] > 1
      end
    end

  end

end
