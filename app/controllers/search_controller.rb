class SearchController < ApplicationController
	def context
		@query = params[:word]
		@contexts = Array.new()
		la = BookLine.find(:all, :conditions => ["line like ?", "%" + @query + "%"])

		for line in la do
			beforeline = BookLine.find(:first, :conditions => ["linenum = ? and source = ?", line.linenum - 1, line.source])
			afterline = BookLine.find(:first, :conditions => ["linenum = ? and source = ?", line.linenum + 1, line.source])
			if (beforeline != nil) then beforeline = beforeline.line end
			if (afterline != nil) then afterline = afterline.line end
			bookname = Book.find(line.source).name
			if (line != nil) then linecontent = line.line end
			@contexts << [beforeline, linecontent, afterline, bookname]
		end
		
	end
	
	def search
		
	end
end
