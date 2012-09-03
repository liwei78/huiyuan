require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should show user" do
    get(:show, {'id' => @user.id}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 3
    assert assigns(:unread) == 2
  end

  test "find, default is today" do
    get(:find, {'id' => @user.id}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 1
  end

  test "find 3days" do
    get(:find, {'id' => @user.id, :day => "3days"}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 3
  end

  test "find 7days" do
    get(:find, {'id' => @user.id, :day => "7days"}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 3
  end

  test "find 1month" do
    get(:find, {'id' => @user.id, :day => "1month"}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 4
  end

  test "find 6month" do
    get(:find, {'id' => @user.id, :day => "6month"}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 6
  end

  test "find all" do
    get(:find, {'id' => @user.id, :day => "all"}, {:signcode => "signcode1", :user_id => @user.id})
    assert_response :success
    assert assigns(:messages).count == 7
  end

end
