class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_menus
  before_filter :load_course_formats

 private
 	def load_menus
 		@menus = Menu.all
 	end

 	def load_course_formats
 		@course_formats = CourseFormat.published_now
 	end
end
