class SearchController < ApplicationController
	def context
		@query = params[:word];
		@contexts = []
	end
	
	def search
	end
end
