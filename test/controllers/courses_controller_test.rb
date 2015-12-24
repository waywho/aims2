require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
  	@course = courses(:one)
    :activate_authlogic
  end

  test "should get index" do
  	get :index
  	assert_response :success
  	assert_not_nil assigns(:courses)
  end

  test "show course" do
  	get :show, :id => @course.id
  	assert_response :success
  end

end
