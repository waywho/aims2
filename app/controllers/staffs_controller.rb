class StaffsController < ApplicationController

	def index
		@staffs = Staff.published_now
	end
end
