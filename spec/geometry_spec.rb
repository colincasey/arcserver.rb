# encoding: utf-8

require 'spec_helper'

describe 'Geometry' do

  include_context "shared stuff"

  it 'creates feature with Geometry class' do

    fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
    f = query_for_random_feature
    f.geometry.should be_kind_of(ArcServer::Geometry::Point)

    g = f.geometry
    g.should respond_to(:extent)
    g.should respond_to(:x)
    g.should respond_to(:y)

    # puts geometry.inspect

  end

end
