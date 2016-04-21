class PagesController < ApplicationController

	def show
		@page = Page.friendly.find(params[:id]).includes(:staffs, :courses, :events, :fees, :klasses, :quotes)
	end
end
