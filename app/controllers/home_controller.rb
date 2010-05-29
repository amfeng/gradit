class HomeController < ApplicationController
	def index
		@wordlists = Query.wordlistByName("Wordist 1")
		puts @wordlists
		@word = Query.wordByWord("vex").first
		puts "Word"
		puts @word
		@user = Query.userByLogin("amber").first
		puts "User"
		puts @user
	end
end
