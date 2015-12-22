class CoursesController < ApplicationController


  def index
    @courses = Course.published
  end

  def show
  	@course = Course.published.friendly.find(params[:id])
  end

  private

  def set_courses
  	@courses = Course.all
  end

  def course_params
    params.require(:course).permit(:name, :description)
  end

end
