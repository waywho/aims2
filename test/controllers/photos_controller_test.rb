require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create_photo" do
  	assert_difference('Photo.count') do
  		post :create, photo: { caption: "test", images: ["image1.jpg", "image2.jpg"], imageable_id: "1", imageable_typ: "Course"}
  	end
  end
end
