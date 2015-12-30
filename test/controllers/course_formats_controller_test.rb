require 'test_helper'

class CourseFormatsControllerTest < ActionController::TestCase
  setup do
    @course_format = course_formats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_formats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_format" do
    assert_difference('CourseFormat.count') do
      post :create, course_format: {  }
    end

    assert_redirected_to course_format_path(assigns(:course_format))
  end

  test "should show course_format" do
    get :show, id: @course_format
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_format
    assert_response :success
  end

  test "should update course_format" do
    patch :update, id: @course_format, course_format: {  }
    assert_redirected_to course_format_path(assigns(:course_format))
  end

  test "should destroy course_format" do
    assert_difference('CourseFormat.count', -1) do
      delete :destroy, id: @course_format
    end

    assert_redirected_to course_formats_path
  end
end
