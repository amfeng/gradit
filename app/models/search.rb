class Search < ActiveRecord::Base
  
  def self.search(query)
	w = Word.find_by_word(query)
  	if(w) #If word exists, context might exist
  		if(w.context_cache) #If word exists in context cache
  			return w.contexts unless w.context_cache.dirty
  		end
  	else #Else, create word
  		w = Word.new(:word => query)
  		w.save	
  	end
  	
  	#Else, have to search from scratch
    @contexts = Array.new()
    la = BookLine.find(:all, :conditions => ["line like ?", "%" + query + "%"])
    
    reg = /\b#{query}\b/i
    
    for line in la do
      if (reg.match(line.line))
        beforeline = BookLine.find(:first, :conditions => ["linenum = ? and source = ?", line.linenum - 1, line.source])
        afterline = BookLine.find(:first, :conditions => ["linenum = ? and source = ?", line.linenum + 1, line.source])
        if (beforeline != nil) then beforeline = beforeline.line end
        if (afterline != nil) then afterline = afterline.line end
        bookname = Book.find(line.source).name
        if (line != nil)
        	linecontent = line.line
        	linecontent.gsub!(query, "<b><u>#{query}</u></b>")
    	end
    	
    	#Add contexts in
    	c = Context.new(:before => beforeline, :after => afterline, :wordline => linecontent)
    	c.book = Book.find(line.source)
    	c.word = w;
    	c.save
    	
        @contexts << c
      end
    end
    #Add to context cache
	if(w.context_cache) 
		w.context_cache.dirty = false
	else
		cc = ContextCache.new(:dirty => false)
		cc.word = w;
		cc.save
	end
    return @contexts
  end
end

