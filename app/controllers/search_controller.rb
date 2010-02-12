class SearchController < ApplicationController
	def context
		@query = params[:word]
		@contexts = Array.new()
		fa = Array.new()
		fa << "h.txt"
		fa << "s.txt"

		for filename in fa do
			f = File.open(filename)
			buf = Array.new(3)
			buf[0] = f.gets
			buf[1] = f.gets
			buf[2] = f.gets
			#puts buf
			count = 0;
			while (line = f.gets)
				if (line != "\n")
					if (buf[1].include?(@query))
						#puts buf
						#puts @contexts
						#puts "FUN HAPPENS HERE"
						@contexts << Array.new(buf)
						puts @contexts
						#puts buf
						count = count+1
					end
					buf.shift
					buf << line
				end
			end
		end
		puts @contexts
	end
	
	def search
		
	end
end
