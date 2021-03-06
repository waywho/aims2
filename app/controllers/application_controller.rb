class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_menus
  before_filter :load_courseformats
  # before_filter :load_news
  before_filter :load_events
  before_filter :load_footer_contact
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
 
	private
	 	def load_menus
	 		@menus = Menu.all
	 	end

	 	def load_courseformats
	 		@courseformats = Courseformat.published_now.rank(:row_order).includes(:courses, :fees)
	 	end

	 	# def load_news
	 	# 	@news = NewsItem.published_now
	 	# end

	 	def load_events
	 		@future_events = Event.future.order(:date)
	 	end

	 	def load_footer_contact
	 		@footer_contact = Page.where(title: 'Footer Contact').first
	 	end

end
