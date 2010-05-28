class HomeController < ApplicationController
	def index
		@wordlists = Wordlist.all
		@user = Query.userByName("Allen")
	end
end
