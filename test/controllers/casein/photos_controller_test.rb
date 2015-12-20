require 'test_helper'

class Casein::PhotosControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
 
  	
  	setup do
  		@admin_user = {username: 'admin', email: 'admin@example.com', password: 'Pottycode1'}
	end	

	test "should get index" do

	   	session[:casein_admin_user_id] = @admin_user

	  	get :index
	  	assert_response :success
	  	assert_not_nil assigns(:photos)
  	end
end
