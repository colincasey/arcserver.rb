# encoding: utf-8

shared_context "shared stuff" do

  before { @some_var = :some_value }

  def query_for_random_feature
    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { geometryType: 'esriGeometryEnvelope', geometry: '{"xmin":997878.8354556253,"ymin":5783588.635939264,"xmax":998147.5593831083,"ymax":5783767.785224252,"spatialReference":{"wkid":102100}}', outFields: "*", inSR: 102100, outSR: 102100 })
    feature_set.features[0]
  end

end
