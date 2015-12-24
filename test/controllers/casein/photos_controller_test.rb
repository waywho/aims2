require 'test_helper'

class Casein::PhotosControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
 
  	
  setup do
    @course = courses(:one)
  end

  setup  :activate_authlogic

  test "should get index" do
    user = FactoryGirl.create(:admin)
    Casein::AdminUserSession.create(user)

	  	get :index
	  	assert_response :success
	  	assert_not_nil assigns(:photos)
  	end
end
