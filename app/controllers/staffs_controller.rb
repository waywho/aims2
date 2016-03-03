class StaffsController < ApplicationController

	def index
		@tags = Staff.tag_counts_on(:speciality)
		if params[:speciality]
			@staffs = Staff.published_now.tagged_with(params[:speciality])
		else
			@staffs = Staff.published_now
		end
	end

	def show
		@staff = Staff.published_now.friendly.find(params[:id])
	end
end
