# encoding: utf-8

shared_context "shared stuff" do

  before { @some_var = :some_value }

  def query_for_random_feature

    feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    feature_set = feature_server.query('0', { where: "status=1", outFields: "*", inSR: 102100, outSR: 102100 })

    # feature_set.features.should_not be_empty
    # feature_set.features.size.should be > 0

    feature_set.features[ Random.rand(100) % feature_set.features.size  ]

  end

end
