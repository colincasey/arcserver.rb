# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

class LegendTest < Test::Unit::TestCase
  fixtures :maps
  should "raise an error if nothing supplied to constructor" do
    assert_raise(ArgumentError) { ArcServer::Legend.new() }
  end

  context "get_image setup" do
  	setup do
  		@legend = ArcServer::Legend.new(maps(:test1)[:legend_info])
	end
  	should "require RMagick" do
  		assert_raise(NameError){@legend.get_image}
  	end
  end
  context "get_image" do
  	
  	setup do
  		require 'rmagick'
  		@legend = ArcServer::Legend.new(maps(:test1)[:legend_info])
  	end
  	should "create an image" do
  		
  		img = @legend.get_image
  		assert_kind_of Magick::Image, img
  	end
  end
end