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
			count = 0;
			while (line = f.gets)
				if (line != "\n")
					if (buf[1].include?(@query))
						temp = Array.new(buf)
						temp << filename
						@contexts << temp
						puts @contexts
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
