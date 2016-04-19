class CoursesController < ApplicationController
	before_action :set_courses

  def index
    @courses = Course.published_now
    @quotes = Quote.all
  end

  def show
  	@course = Course.published_now.friendly.find(params[:id])
    @quotes = Quote.all
  end

  private

  def set_courses
  	@courses = Course.published_now
  end

end
