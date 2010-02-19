class HomeController < ApplicationController
	def index
		@wordlists = Wordlist.all
		
	end
end
