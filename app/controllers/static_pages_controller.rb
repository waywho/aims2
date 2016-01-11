class StaticPagesController < ApplicationController

	def home
		@events = Event.future.order(:date)
		@courses = Course.published_now.main_course
		@feature_courseformat = Courseformat.find_by(title: "Summer School 2016")
	end
end
