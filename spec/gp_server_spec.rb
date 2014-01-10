# encoding: utf-8

require 'spec_helper'

describe 'GPServer' do

  context 'when the GP is synchronous' do
    it "sends a message in a bottle" do

      gp = ArcServer::GPServer.new("http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_Currents_World/GPServer/MessageInABottle")
      feature = ArcServer::Graphics::Feature.new({ geometry: ArcServer::Geometry::Point.new({ x: -76.2890625, y: 35.859375, spatialReference: { wkid: 4326 } }) })
      feature_set = ArcServer::Graphics::FeatureSet.new({ features: [ feature ] })

      params = { Input_Point: feature_set.to_json, Days: 180 }
      results =  gp.execute(params)

      results.should_not be nil
      results.should have_key :paramName
      results.should have_key :value

    end

    it "executes export Web Map Task" do
      gp = ArcServer::GPServer.new("http://sampleserver6.arcgisonline.com/arcgis/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task")

      webmap = '{"mapOptions":{"showAttribution":true,"extent":{"xmin":-9653813.186180541,"ymin":4553927.749172574,"xmax":-9427865.330569474,"ymax":4689068.415180817,"spatialReference":{"wkid":102100}},"spatialReference":{"wkid":102100},"scale":577790.5542889992},"operationalLayers":[{"id":"Ocean_Basemap_5301","title":"Ocean_Basemap_5301","opacity":1,"minScale":591657527.591555,"maxScale":9027.977411,"url":"http://services.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer"},{"id":"LOJIC_LandRecords_Louisville_3326","title":"LOJIC_LandRecords_Louisville_3326","opacity":0.24,"minScale":0,"maxScale":0,"url":"http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Louisville/LOJIC_LandRecords_Louisville/MapServer","visibleLayers":[0,2],"layers":[]},{"id":"map_graphics","minScale":0,"maxScale":0,"featureCollection":{"layers":[]}}],"exportOptions":{"outputSize":[800,1100],"dpi":96},"layoutOptions":{"titleText":"Louisville – Land Records, Portrait JPG","scaleBarOptions":{},"legendOptions":{"operationalLayers":[]}}}'

      params = { Web_Map_as_JSON: webmap, Format: 'JPG', Layout_Template: 'MAP_ONLY' }
      results = gp.execute(params)
      results.should have_key('Output_File')
      results['Output_File'].should have_key("url")
      results['Output_File']['url'].should match /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6}):?(\d{1,6})*([\/\w \.-]*)*\/?$/
    end

  end

  context 'when the GP is aynchronous' do

    it "executes a Geo Processing Tool" do

      gp = ArcServer::GPServer.new("http://sampleserver6.arcgisonline.com/arcgis/rest/services/911CallsHotspot/GPServer/911%20Calls%20Hotspot")
      q = "(Date >= date '1998-01-01 12:00:00' and Date <= date '1998-01-07 12:00:00') AND (Day = 'SUN' OR Day= 'SAT' OR Day = 'FRI' OR Day ='MON' OR Day='TUE' OR Day='WED' OR Day ='THU')"
      params = { Query: q }

      gp.submitJob(params) do |results|
        results.should have_key('Output_Features')
        results.should have_key('Hotspot_Raster')
        results['Hotspot_Raster'].should have_key('mapImage')
      end

    end

  end

end
