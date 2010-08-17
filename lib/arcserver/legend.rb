# encoding: utf-8

module ArcServer
	class Legend
		DefaultLegendWidth=250
		def initialize(li, opts = {})
			@legend_info=li
		end
		
		def get_image(args={})
	      	
			#qualified_const_get("RMagick")
			
			height,width = determine_legend_size()
	      	
	      	legend = Magick::Image.new(width,height)
			gc = Magick::Draw.new
			#gc.font = "helvetica"
			gc.stroke_antialias(false)
			gc.text_antialias = false
			gc.density = "96x96"
			
			y = 0
			@legend_info.each do |l|
				name= l[:name]
				puts "Working on layer #{name}"
				gc.text(10,y+=30, name)
				gc.draw(legend)
				y-=15
				l_classes = l[:legend_groups][0][:legend_classes]
				l_classes.each do |lc|
					img2=Image.read_inline(lc[:symbol_image][:image_data])
					legend.composite!(img2[0],20,y+=25,OverCompositeOp)
					gc.text(50,y+14, lc[:label]) unless lc[:label].nil?
					gc.draw(legend)
				end	
				y+=5
			end
			legend
	  	end
		  	
	  	private
  		def determine_legend_size()
	  		
	    	wd = DefaultLegendWidth
	    	puts @legend_info.length
	     	ht = @legend_info.inject(0) do  |height, li|
				l_classes = li[:legend_groups][0][:legend_classes]
				l_classes.each do |lc|
					if (!lc[:label].nil?)
						puts lc[:label]
						wd = (lc[:label].length * 10) unless wd > (lc[:label].length * 10)
					end
					
				end
				height+= (20+(25* l_classes.length))
				
			end
			puts ht
			[ht + 20,wd]   	
	    end
	
	  	def qualified_const_get(str)
		    path = str.to_s.split('::')
		    from_root = path[0].empty?
		    if from_root
		      from_root = []
		      path = path[1..-1]
		    else
		      start_ns = ((Class === self)||(Module === self)) ? self : self.class
		      from_root = start_ns.to_s.split('::')
		    end
		    until from_root.empty?
		      begin
		        return (from_root+path).inject(Object) { |ns,name| ns.const_get(name) }
		      rescue NameError
		        from_root.delete_at(-1)
		      end
		    end
		    path.inject(Object) { |ns,name| ns.const_get(name) }
	  	end
	end
  
end