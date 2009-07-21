# encoding: utf-8
require File.dirname(__FILE__) + '/../../test_helper'
require 'yaml'

#ArcServer::SOAP::MapServer.logger = $stdout

class ArcServer::SOAP::MapServerTest < Test::Unit::TestCase
  should "be able to use map services at two different locations" do
    service1 = ArcServer::SOAP::MapServer.new('http://sampleserver1.arcgisonline.com/ArcGIS/services/Portland/ESRI_LandBase_WebMercator/MapServer')
    service2 = ArcServer::SOAP::MapServer.new('http://sampleserver1.arcgisonline.com/ArcGIS/services/Demographics/ESRI_Census_USA/MapServer')

    name1 = service1.get_default_map_name
    name2 = service2.get_default_map_name

    assert_equal "Portland", name1
    assert_equal "Layers",   name2
  end

  context "using ESRI's sample Portland Landbase service" do
    setup do
      @service = ArcServer::SOAP::MapServer.new('http://sampleserver1.arcgisonline.com/ArcGIS/services/Portland/ESRI_LandBase_WebMercator/MapServer')
    end

    should "get the default map name" do
      assert_equal "Portland", @service.get_default_map_name
    end

    should "get the legend info" do
      legend_info = @service.get_legend_info(:map_name => 'Portland')
      legend_info.each do |item|
        layer_assertion = "assert_legend_info_result_layer_#{item[:layer_id]}".to_sym
        if respond_to?(layer_assertion)
          send(layer_assertion, item)
        else
          raise "no assertions set for legend info with layer_id=#{item[:layer_id]}"
        end
      end
    end
  end

  # legend info assertion helpers
  def assert_legend_info_result_layer_1(item)
    expected = {
      :layer_id => 1,
      :name => 'Zoomed in',
      :legend_groups => [{
          :legend_classes => [{
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nR0lEQVR4nGP89/8/AzUBC4wR4O9PkckbNm5kZGBgYGCihmHIZrAgC8JsIdcwBgaoC6kJRg0cNXAw\nGIiSU6iRBanuQkZqF18AsvET5O8fag8AAAAASUVORK5CYII=\n"
              }
            }]
        }]
    }
    assert_legend_info_result_layer(expected, item)
  end

  def assert_legend_info_result_layer_2(item)
    expected = {
      :layer_id => 2,
      :name => 'Zoomed out',
      :legend_groups => [{
          :legend_classes => [{
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nPklEQVR4nGP89/8/AzUBE1VNY2BgYIExAvz9KXbqho0bGVnQBcg1DOYgqnt51MBRA4elgShZjxr5\nmZHaxRcATwAQChHiw9IAAAAASUVORK5CYII=\n"
              }
            }]
        }]
    }
    assert_legend_info_result_layer(expected, item)
  end

  def assert_legend_info_result_layer_3(item)
    expected = {
      :layer_id => 3,
      :name => 'Buildings',
      :legend_groups => [{
          :legend_classes => [{
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nNElEQVR4nGP89/8/AzUBE1VNY2BgYIExZtTVUeTUjKYmRgYGGrhw1MBRA0cNJAYwDvrSBgCGTgoZ\ncGsDFQAAAABJRU5ErkJggg==\n"
              }
            }]
        }]
    }
    assert_legend_info_result_layer(expected, item)
  end

  def assert_legend_info_result_layer_4(item)
    expected = {
      :layer_id => 4,
      :name => 'Zoning',
      :legend_groups => [{
          :legend_classes => [{
              :label => 'Commercial',
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nNElEQVR4nGP89/8/AzUBE1VNY2BgYIExXjAyUuRUif//GRkYaODCUQNHDRw1kBjAOOhLGwBbzgoZ\npkxTgAAAAABJRU5ErkJggg==\n"
              }
            }, {
              :label => 'Industrial',
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nNElEQVR4nGP89/8/AzUBE1VNY2BgYIEx2hhXUuTUqv/hjAwMNHDhqIGjBo4aSAxgHPSlDQBtTgoZ\nvbcuLAAAAABJRU5ErkJggg==\n"
              }
            }, {
              :label => 'Residential',
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nNElEQVR4nGP89/8/AzUBE1VNY2BgYIExGBlKKHLqf4YeRgYGGrhw1MBRA0cNJAYwDvrSBgAaUgkZ\nJEjqtwAAAABJRU5ErkJggg==\n"
              }
            }, {
              :label => 'Mixed use',
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nNElEQVR4nGP89/8/AzUBE1VNY2BgYIExvuW5UORUrkl7GBkYaODCUQNHDRw1kBjAOOhLGwCLTgoZ\nUbp19QAAAABJRU5ErkJggg==\n"
              }
            }, {
              :label => 'Parks and open space',
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nOUlEQVR4nGP89/8/AzUBE1VNY2BgYIExGBkYKHLqfwYGRgYGGrhw1MBRA0cNJAbA8zIsL1IKqO5C\nAJdcBiBRj7wXAAAAAElFTkSuQmCC\n"
              }
            }, {
              :label => 'Rural',
              :symbol_image => {
                :image_data => "iVBORw0KGgoAAAANSUhEUgAAABQAAAAQCAYAAAAWGF8bAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA\nNElEQVR4nGP89/8/AzUBE1VNY2BgYIExus+lU+TUUqOZjAwMNHDhqIGjBo4aSAxgHPSlDQCRTgoZ\nWZnonwAAAABJRU5ErkJggg==\n"
              }
            }]
        }]
    }
    assert_legend_info_result_layer(expected, item)
  end
  
  def assert_legend_info_result_layer(expected, actual)
    assert_equal expected[:layer_id], actual[:layer_id]
    assert_equal expected[:name], actual[:name]
    # check the legend groups
    assert_equal expected[:legend_groups].length, actual[:legend_groups].length
    actual[:legend_groups].each do |legend_group|
      assert_legend_group expected[:legend_groups].shift, legend_group
    end
  end

  def assert_legend_group(expected, actual)
    assert_equal expected[:heading], actual[:heading]
    # check the legend classes
    assert_equal expected[:legend_classes].length, actual[:legend_classes].length
    actual[:legend_classes].each do |legend_class|
      assert_legend_class expected[:legend_classes].shift, legend_class
    end
  end

  def assert_legend_class(expected, actual)
    assert_equal expected[:label], actual[:label]
    assert_equal expected[:description], actual[:description]
    assert_symbol_image(expected[:symbol_image] || {}, actual[:symbol_image])
    assert_transparent_color(expected[:transparent_color] || {}, actual[:transparent_color])
  end

  def assert_symbol_image(expected, actual)
    assert_equal expected[:image_data], actual[:image_data]
    assert_equal expected[:image_url], actual[:image_url]
    assert_equal expected[:image_height] || 16, actual[:image_height]
    assert_equal expected[:image_width] || 20, actual[:image_width]
    assert_equal expected[:image_dpi] || 96, actual[:image_dpi]
  end

  def assert_transparent_color(expected, actual)
    assert_equal expected[:use_windows_dithering] || true, actual[:use_windows_dithering]
    assert_equal expected[:alpha_value] || 255, actual[:alpha_value]
    assert_equal expected[:red] || 254, actual[:red]
    assert_equal expected[:green] || 255, actual[:green]
    assert_equal expected[:blue] || 255, actual[:blue]
  end
end
