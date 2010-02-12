class SearchController < ApplicationController
	def context
		@query = params[:word];
	end
	
	def search
	end
end
