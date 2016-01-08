class StaticPagesController < ApplicationController

	def home
		@events = Event.future.order(:date)
		@courses = Course.published_now.main_course
	end
end
