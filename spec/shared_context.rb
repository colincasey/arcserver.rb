# encoding: utf-8

shared_context "shared stuff" do

  def query_for_random_feature
    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { where: "status=1", outFields: "*", returnGeometry: true })
    feature_set.features[ Random.rand(1000) ]
  end

  def query_for_id(id)
    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { objectIds: id, outFields: "*", returnGeometry: true })
    feature_set.features[0]
  end

end
