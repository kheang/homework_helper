require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get chosen" do
    get :chosen
    assert_response :success
  end

end
