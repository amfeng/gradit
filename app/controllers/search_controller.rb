class SearchController < ApplicationController
	def get_context
		query = params[:word];
	end
end
