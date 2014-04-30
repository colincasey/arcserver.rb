# encoding: utf-8

require 'spec_helper'

describe 'FeatureServer' do

  include_context "shared stuff"

  it 'adds feature to FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")

    # objectid (Type: esriFieldTypeOID, Alias: Object ID, Editable: False)
    # req_id (Type: esriFieldTypeString, Alias: Request ID, Length: 20, Editable: True)
    # req_type (Type: esriFieldTypeString, Alias: Request Type, Length: 40, Editable: True)
    # req_date (Type: esriFieldTypeString, Alias: Request Date, Length: 30, Editable: True)
    # req_time (Type: esriFieldTypeString, Alias: Request Time, Length: 20, Editable: True)
    # address (Type: esriFieldTypeString, Alias: Address, Length: 60, Editable: True)
    # x_coord (Type: esriFieldTypeString, Alias: X Coordinate, Length: 20, Editable: True)
    # y_coord (Type: esriFieldTypeString, Alias: Y Coordinate, Length: 20, Editable: True)
    # district (Type: esriFieldTypeString, Alias: District, Length: 20, Editable: True)
    # status (Type: esriFieldTypeSmallInteger, Alias: Status, Editable: True, Domain: Coded Values: [1: New], [2: Open], [3: Closed])

    attrs = {
      status:    "1",
      req_id:    "12345",
      req_type:  "Graffiti Complaint – Private Property",
      req_date:  "30.09.2013",
      req_time:  "14:00",
      address:   "via dei matti 1",
      district:  "Lugano"
    }

    geometry = ArcServer::Geometry::Point.new({ x: 997986.50, y: 5783631.06, spatialReference: { wkid: 102100 }})

    f = ArcServer::Graphics::Feature.new({ geometry: geometry, attributes: attrs })

    results = fs.applyEdits('0', [ f ], [ ], [  ])
    results.should have_key(:addResults)
    results[:addResults].should have(1).item
    results[:addResults].each do |r|
      r.should have_key(:objectId)
      r.should have_key(:success)
      r[:success].should be true
    end

  end

  it 'updates feature on FeatureServer' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = query_for_random_feature

    f.attributes[:address] = "The Avengers Tower"

    results = fs.applyEdits('0', [  ], [ f ], [  ])
    results.should have_key(:updateResults)
    results[:updateResults].each do |r|
      r.should have_key(:objectId)
      r.should have_key(:success)
      r[:success].should be true
    end
  end

  it 'deletes features' do

    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { where: 'status=1', outFields: "*", inSR: 102100, outSR: 102100 })

    deletes = feature_set.features[1..3].map { |f| f.attributes[:objectid] }.join(',')
    results = feature_server.applyEdits('0', [  ], [  ], deletes)
    results.should have_key(:deleteResults)

  end

end
