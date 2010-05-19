class BookController < ApplicationController
	def create
      book = Book.new(:name=>params[:book][:name])
#	  puts "\n\n\n"
#	  puts "params[:book][:name] = "
#      puts params[:book][:content]
#	  puts "\n\n\n"
	  book.save
      text = params[:books][:content]
      file = params[:textfile]
      content = text.empty? ? File.open(file) : text
      if content.is_a?(File)
        tmp = ""
        while(line = content.gets)
		  line.gsub("\n", "")
          tmp << " " << line
        end
        content = tmp
      end
	  
	  content = content.split(/[\.\?\!]+[\n]/)
	  
      num = 0
      for line in content
        a = BookLine.new(:line=>line,:linenum=>num)
        a.source = book.id
        a.save
        num=num+1
      end
	end
	
	def new
		@book = Book.new
	end
end
