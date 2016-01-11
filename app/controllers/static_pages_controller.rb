class StaticPagesController < ApplicationController
	before_filter :load_news_list

	def home
		@events = Event.future.order(:date)
		@courses = Course.published_now.main_course
		@feature_courseformat = Courseformat.find_by(title: "Summer School 2016")
	end

	private

	def load_news_list
		news = News.published_now
		events = Event.future.order(:date)
		@news_items = []
		news.map { |n| @news_items.push(n) }
		events.map { |e| @news_items.push(e) }
		@news_items.sort_by { |i| i[:created_at] }
	end
end
