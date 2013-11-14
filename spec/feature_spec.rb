# encoding: utf-8

require 'spec_helper'

describe 'Feature Specs' do

  it "create a feature from JSON" do
    json = '{ "geometry" : { "x" : -118.15, "y" : 33.80 }, "attributes" : { "OWNER" : "Joe Smith", "VALUE" : 94820.37, "APPROVED" : true, "LASTUPDATE" : 1227663551096 } }'
    feature = ArcServer::Graphics::Feature.create(json)

    feature.should be_kind_of(ArcServer::Graphics::Feature)
    feature.geometry.should be_kind_of(ArcServer::Geometry::Point)
    feature.geometry.x.should eq -118.15
    feature.geometry.y.should eq 33.80
    feature.attributes.should have_key("OWNER")
    feature.attributes.should have_key("VALUE")

  end

end
