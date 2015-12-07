class CoursesController < ApplicationController
	before_action :set_courses

  def index
    @courses = Course.all
  end

  def show
  	@course = Course.friendly.find(params[:id])
  end

  private

  def set_courses
  	@courses = Course.all
  end

  def course_params
    params.require(:course).permit(:name, :description)
  end

end
