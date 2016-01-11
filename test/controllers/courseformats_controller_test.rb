require 'test_helper'

class CourseformatsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @courseformat = courseformats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courseformats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create courseformat" do
    assert_difference('CourseFormat.count') do
      post :create, courseformat: {  }
    end

    assert_redirected_to courseformat_path(assigns(:courseformat))
  end

  test "should show courseformat" do
    get :show, id: @courseformat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @courseformat
    assert_response :success
  end

  test "should update courseformat" do
    patch :update, id: @courseformat, courseformat: {  }
    assert_redirected_to courseformat_path(assigns(:courseformat))
  end

  test "should destroy courseformat" do
    assert_difference('CourseFormat.count', -1) do
      delete :destroy, id: @courseformat
    end

    assert_redirected_to courseformats_path
  end
end
