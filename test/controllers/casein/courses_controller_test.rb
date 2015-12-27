require 'test_helper'

class Casein::CoursesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end


  setup do
    @course = FactoryGirl.create(:course)
  end

  setup  :activate_authlogic

  test "should get index" do
    user = FactoryGirl.create(:admin)
    Casein::AdminUserSession.create(user)

	  	get :index
	  	assert_response :success
	  	assert_not_nil assigns(:courses)
  end


  test "show course" do
   	user = FactoryGirl.create(:admin)
    Casein::AdminUserSession.create(user)
  	
  	get :show, :id => @course.id
  	assert_response :success
  end
end
