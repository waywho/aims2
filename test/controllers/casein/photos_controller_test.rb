require 'test_helper'

class Casein::PhotosControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
 
  setup do
    @photo = FactoryGirl.create(:photo)
  end

  setup  :activate_authlogic

  test "should get index" do
    user = FactoryGirl.create(:admin)
    Casein::AdminUserSession.create(user)

	  	get :index
	  	assert_response :success
	  	assert_not_nil assigns(:photos)
  end

  # test "show photo" do
  #   user = FactoryGirl.create(:admin)
  #   Casein::AdminUserSession.create(user)
    
  #   get :show, :id => @photo.id #unknown format error
  #   assert_response :success
  # end

  test "should create photo" do
    user = FactoryGirl.create(:admin)
    Casein::AdminUserSession.create(user)

    assert_difference('Photo.count') do
      post :create, photo: { caption: "MyCaption", image: "image1.jpg" }
    end
  end

end
