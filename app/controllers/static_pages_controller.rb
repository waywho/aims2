class StaticPagesController < ApplicationController
	before_filter :load_news_list

	def home
		@feature_pages = Page.where(feature: true).limit(3)
		@feature_format = Courseformat.find_by(feature: true)
		@feature_courses = @feature_format.courses.feature_courses
		@quotes = Quote.all

		load_event_dates
	end

	def get_calendar
		load_event_dates

  		respond_to do |format|
  			format.js
  		end
	end


	def terms_and_conditions
	end

	def privacy_policy
	end

	def contact
		@contact_info = Page.where(title: 'Footer Contact').first
	end

	def send_contact
		if verify_recaptcha
			NotificationMailer.contact(contact_params[:name], contact_params[:email], contact_params[:subject], contact_params[:message])
			flash[:notice] = "Thank you. Your message has been sent."
			redirect contact_path
		else
			flash[:error] = "Are you sure you are not a robot? Make sure you verify your human status."
			redirect contact_path
		end
	end 

	private
	def contact_params
		params.require(:contact).permit(:name, :email, :subject, :message)
	end

	def load_news_list
		news = NewsItem.published_now.limit(5)
		events = Event.future.order(:date).limit(5)
		@news_items = []
		news.map { |n| @news_items.push(n) }
		events.map { |e| @news_items.push(e) }
		@news_items.sort_by { |i| i[:published_at] }
	end

	def load_event_dates
		if Event.published_now.present?
			@date = params[:date] ? Date.parse(params[:date]) : Date.parse(Event.published_now.first.date.to_s)
		else
			@date = params[:date] ? Date.parse(params[:date]) : Date.today
		end
  		if Event.published_now.where(date: @date.beginning_of_day..@date.end_of_day).present?
	  		@day_events = Event.published_now.where(date: @date.beginning_of_day..@date.end_of_day).order(:date)
	  		@events = @future_events.where("date >= ?", @date.tomorrow).order(:date)
  		else
  			@events = Event.published_now.where("date >= ?", @date.beginning_of_month).order(:date)
  		end
  		@events_by_date = @future_events.group_by {|t| t.date.to_formatted_s(:numerals)}
	end
end
