class HomeController < ApplicationController
	def index
		puts "Wordlist"
		@wordlists = Query.wordlistByName("amber")
		puts @wordlists
		@wordlists = Query.wordlistByName("hello")
		puts @wordlists
		@word = Query.wordByWord("vex").first
		puts "Word"
		puts @word
		@user = Query.userByLogin("amber").first
		puts "User"
		puts @user
		session[:current_user] = @user
	end
end
