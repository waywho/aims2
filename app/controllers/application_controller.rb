class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_menus
  before_filter :load_courseformats
  before_filter :load_courses

 private
 	def load_menus
 		@menus = Menu.all
 	end

 	def load_courseformats
 		@courseformats = Courseformat.published_now.rank(:row_order)
 	end

 	def load_courses
 		@courses = Course.published_now.rank(:row_order)
 	end
end
