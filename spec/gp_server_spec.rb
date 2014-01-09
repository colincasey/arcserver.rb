# encoding: utf-8

require 'spec_helper'

describe 'GPServer' do

  context 'when the GP is synchronous' do
    it "sends a message in a bottle" do

      gp = ArcServer::GPServer.new("http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_Currents_World/GPServer/MessageInABottle")
      feature = ArcServer::Graphics::Feature.new({ geometry: ArcServer::Geometry::Point.new({ x: -76.2890625, y: 35.859375, spatialReference: { wkid: 4326 } }) })
      feature_set = ArcServer::Graphics::FeatureSet.new({ features: [ feature ] });

      params = { Input_Point: feature_set.to_json, Days: 180 }
      results =  gp.execute(params)

      results.should_not be nil
      results.should have_key :paramName
      results.should have_key :value

    end
  end

  context 'when the GP is aynchronous' do

    it "executes export Web Map Task" do
      gp = ArcServer::GPServer.new("http://srvgists006.lugano.ch:6080/arcgis/rest/services/Geoprocessing/ExportWebMap/GPServer/Export%20Web%20Map")
      params = { Web_Map_as_JSON: File.open('spec/webmap.json', "rb").read, Format: 'JPG', Layout_Template: 'MAP_ONLY' }
      gp.submitJob(params) do |results|
        results.should have_key('Output_File')
        results['Output_File'].should have_key("url")
        results['Output_File']['url'].should match /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6}):?(\d{1,6})*([\/\w \.-]*)*\/?$/
      end
    end

    it "executes a Geo Processing Tool" do

      gp = ArcServer::GPServer.new("http://gis.lugano.ch/arcgis/rest/services/GisWeb/GPServer/GWClip")

      particella = '{"features":[{"geometry":{"rings":[[[717172.6070000008,95751.06210000068],[717158.6838999987,95784.61699999869],[717154.0441000015,95795.80009999871],[717154.5069999993,95795.98910000175],[717154.3260000013,95796.42799999937],[717163.7069999985,95800.2501000017],[717163.5260000005,95800.6950000003],[717173.6851000004,95804.83399999887],[717173.8660999984,95804.3898999989],[717183.257100001,95808.21599999815],[717183.4420999996,95807.77910000086],[717183.9050000012,95807.96810000017],[717202.3891000003,95763.03290000185],[717196.4549000002,95760.59910000116],[717196.6218999997,95760.18100000173],[717178.7580000013,95753.0540000014],[717178.5909999982,95753.47190000117],[717172.6070000008,95751.06210000068]]]}}]}'

      params = { Feature_Set: particella }

      gp.submitJob(params) do |results|
        zone = results['zone_clipped']
        zone.should_not be_nil
        zone.should be_kind_of(ArcServer::Graphics::FeatureSet)
        zone.should respond_to(:features)
        zone.features.each do |f|
          ["AP-EP", "Strada"].should include f.attributes[:ZONA]
        end
      end

    end

  end

end
