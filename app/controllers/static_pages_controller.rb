class StaticPagesController < ApplicationController
	before_filter :load_news_list

	def home
		@feature_page = Page.find_by(feature_page: true)
		@events = Event.future.order(:date)
		@feature_format = Courseformat.find_by(homepage_feature: true)
		@feature_courses = @feature_format.courses.limit(4).rank(:row_order)
		@quotes = Quote.all
	end

	private

	def load_news_list
		news = NewsItem.published_now
		events = Event.future.order(:date)
		@news_items = []
		news.map { |n| @news_items.push(n) }
		events.map { |e| @news_items.push(e) }
		@news_items.sort_by { |i| i[:created_at] }
	end
end
