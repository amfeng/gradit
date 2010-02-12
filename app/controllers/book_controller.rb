class BookController < ApplicationController
	def create
      book = Book.new(:name=>params[:name])
      content = params[:content].split("\n")
      num = 0
      for line in content
        a = BookLine.new(:line=>line,:linenum=>num)
        a.source = book
        a.save
        num=num+1
      end
	  book.save
	end
end
