require 'test_helper'

class MainControllerTest < ActionController::TestCase

  test "index page without user" do
    get :index, nil, nil
    assert_response :success
    assert assigns(:user).nil?
  end

  test "index page with user" do
    get :index, {'id' => '1'}, {:signcode => "china", :user_id => 1}
    assert_redirected_to user_url(1)
  end


end