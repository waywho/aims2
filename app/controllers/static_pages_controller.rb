class StaticPagesController < ApplicationController
	before_filter :load_news_list

	def home
		@feature_page = Page.find_by(feature: true)
		@events = Event.future.order(:date).limit(5)
		@feature_format = Courseformat.find_by(feature: true)
		@feature_courses = @feature_format.courses.feature_courses
		@quotes = Quote.all
	end

	private

	def load_news_list
		news = NewsItem.published_now.limit(5)
		events = Event.future.order(:date).limit(5)
		@news_items = []
		news.map { |n| @news_items.push(n) }
		events.map { |e| @news_items.push(e) }
		@news_items.sort_by { |i| i[:created_at] }
	end
end
