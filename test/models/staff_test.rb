require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should accept nested photo for staff" do
  	staff = Staff.create(name: "A name", biography: "Some biog", photo_attributes: {image: "image1.jpg", caption: "test"})
  	expected = staff.photo.image.to_s
  	actual = "image1.jpg"

  	assert_equal expected, actual
  end
end
