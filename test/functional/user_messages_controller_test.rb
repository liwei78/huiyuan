require 'test_helper'

class UserMessagesControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
  end
  
  test "read all" do
    post :readall, {'id' => '1'}, {:signcode => "china", :user_id => 1}
    assert @user.unread_count == 0
    assert_redirected_to user_url(@user)
  end
  
  test "show" do
    get :show, {'id' => '1'}, {:signcode => "china", :user_id => 1}
    assert_response :success
    assert assigns(:message).read == true
  end
  
end