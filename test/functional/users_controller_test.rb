require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should show user" do
    get(:show, {'id' => '1'}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 7
    assert @user.unread_count == 2
  end

  test "find, default is today" do
    get(:find, {'id' => '1'}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 1
  end

  test "find 3days" do
    get(:find, {'id' => '1', :day => "3days"}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 3
  end

  test "find 7days" do
    get(:find, {'id' => '1', :day => "7days"}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 3
  end

  test "find 1month" do
    get(:find, {'id' => '1', :day => "1month"}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 4
  end

  test "find 6month" do
    get(:find, {'id' => '1', :day => "6month"}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 6
  end

  test "find all" do
    get(:find, {'id' => '1', :day => "all"}, {:signcode => "china", :user_id => 1})
    assert_response :success
    assert assigns(:messages).count == 7
  end

end
