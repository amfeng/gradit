class BookController < ApplicationController
	def create
      book = Book.new(:name=>params[:book][:name])
#	  puts "\n\n\n"
#	  puts "params[:book][:name] = "
#      puts params[:book][:content]
#	  puts "\n\n\n"
	  book.save
	  content = params[:book][:content].split("\n")
      num = 0
      for line in content
        a = BookLine.new(:line=>line,:linenum=>num)
        a.source = book.id
        a.save
        num=num+1
      end
	end
end
