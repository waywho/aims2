class PagesController < ApplicationController

	def show
		@page = Page.includes(:staffs, :courses, :events, :fees, :klasses, :quotes).friendly.find(params[:id])
	end
end
