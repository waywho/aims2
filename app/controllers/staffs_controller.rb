class StaffsController < ApplicationController

	def index
		@staffs = Staff.published_now
	end

	def show
		@staff = Staff.published_now.friendly.find(params[:id])
	end
end
