class CoursesController < ApplicationController
	before_action :set_courses

  def index
    @courses = Course.all
  end

  def show
  	@course = Course.find(params[:id])
  end

  private

  def set_courses
  	@courses = Course.all
  end

end
