# encoding: utf-8

module ArcServer
  module Util
    class LegendImage
      DEFAULT_LEGEND_WIDTH = 250

      def initialize(map_server)
        @map_server = map_server
      end
		
      def get_image	      					      	
        legend_image = Magick::Image.new(*determine_legend_size)

        gc = Magick::Draw.new
        gc.stroke_antialias(false)
        gc.text_antialias = false
        gc.density = "96x96"
			
        y = 0
        legend_info.each do |legend|
          name = legend[:name]          
          gc.text(10, y+=30, name)

          gc.draw(legend_image)
          y -= 15

          legend_classes = legend[:legend_groups][0][:legend_classes]
          legend_classes.each do |legend_class|
            img = Magick::Image.read_inline(legend_class[:symbol_image][:image_data])
            legend_image.composite!(img[0], 20, y+=25, Magick::OverCompositeOp)
            gc.text(50, y+14, legend_class[:label]) unless legend_class[:label].nil?
            gc.draw(legend_image)
            img.destroy!
          end

          y += 5
        end

        legend_image
	  	end
		  	
	  	private
  		def determine_legend_size	  		
	    	width = DEFAULT_LEGEND_WIDTH

        height = legend_info.inject(0) do  |h, legend|
          legend_classes = legend[:legend_groups][0][:legend_classes]

          # expand the legend width if labels are present
          legend_classes.each do |legend_class|
            if label = legend_class[:label]
              label_width = label.length * 10
              width = width > label_width ? width : label_width
            end
          end

          h += (20 + (25 * legend_classes.length))
        end

        [width, height + 20]
	    end

      def legend_info
        @legend_info ||= @map_server.get_legend_info
      end
    end
  end
end