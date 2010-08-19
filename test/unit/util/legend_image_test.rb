# encoding: utf-8
require File.dirname(__FILE__) + '/../../test_helper'
require 'RMagick'

class ArcServer::Util::LegendImageTest < Test::Unit::TestCase
  should "raise an error if nothing supplied to constructor" do
    assert_raise(ArgumentError) { ArcServer::Util::LegendImage.new }
  end

  context "with third party libraries mocked out" do
    setup do
      legend_info = test_legend_info
      map_server = mock('map_server') { stubs(:get_legend_info).returns(legend_info) }
      @legend = ArcServer::Util::LegendImage.new(map_server)

      mock_symbol_image = mock('symbol_image') do
        expects(:[]).times(3).returns(self)
        expects(:destroy!).times(3)
      end
      Magick::Image.expects(:read_inline).with("AAA").returns(mock_symbol_image)
      Magick::Image.expects(:read_inline).with("BBB").returns(mock_symbol_image)
      Magick::Image.expects(:read_inline).with("CCC").returns(mock_symbol_image)

      mock_image = mock('image') do
        stubs(:cur_image)
        expects(:composite!).with(mock_symbol_image, 20, 40, Magick::OverCompositeOp)
        expects(:composite!).with(mock_symbol_image, 20, 65, Magick::OverCompositeOp)
        expects(:composite!).with(mock_symbol_image, 20, 110, Magick::OverCompositeOp)
      end
      Magick::Image.expects(:new).returns(mock_image)      

      mock_draw = mock('draw') do
        stubs(:draw)
        stubs(:stroke_antialias)
        stubs(:text_antialias=)
        stubs(:density=)
        expects(:text).with(10, 30, "Legend 1")
        expects(:text).with(50, 54, "Symbol 1")
        expects(:text).with(50, 79, "Symbol 2")
        expects(:text).with(10, 100, "Legend 2")
      end
      Magick::Draw.expects(:new).returns(mock_draw)

    end

    should "be able to retrieve legend image" do
      @legend.get_image
    end
  end

  def test_legend_info
    [{
      :name => "Legend 1",
      :legend_groups => [
        :legend_classes => [
          { :label => "Symbol 1", :symbol_image => { :image_data => "AAA" } },
          { :label => "Symbol 2", :symbol_image => { :image_data => "BBB" } }
        ]
      ]
    }, {
      :name => "Legend 2",
      :legend_groups => [
        :legend_classes => [
          { :symbol_image => { :image_data => "CCC" } }
        ]
      ]
    }]
  end
end