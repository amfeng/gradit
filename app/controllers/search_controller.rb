class SearchController < ApplicationController
	def context
		@query = params[:word]
		@contexts = Search.search(@query);		
	end
	
	def search
		
	end
end
