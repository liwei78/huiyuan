# encoding: utf-8
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

  test "test user login" do
    puts "Create a new user"
    user = User.create(:login => "harry", :password => "1234", :password_confirmation => "1234", :name => "potter")
    
    puts "First login, ok"
    post :checklogin, {:login => "harry", :password => "1234"}, nil
    assert_redirected_to user_url(user)
    
    puts "Twice login, error"
    post :checklogin, {:login => "harry", :password => "1234"}, nil
    assert_redirected_to root_url
    assert_equal "您已经处于登录状态，此次登录无效。<a href='/force_logout'>点击此处注销登陆</a>", flash[:error]
    
    puts "Error login"
    user.update_attribute(:online, false)
    post :checklogin, {:login => "error", :password => "error"}, nil
    assert_redirected_to root_url
    assert_equal "登录失败", flash[:error]
    
    puts "Logout and Login, ok"
    get :logout
    assert_redirected_to root_url
    post :checklogin, {:login => "harry", :password => "1234"}, nil
    assert_redirected_to user_url(user)
  end
  
  test "force user logout" do
    puts "Create a new logout user"
    user = User.create(:login => "outme", :password => "1234", :password_confirmation => "1234", :name => "outme", :online => true)
    
    post :checkforcelogout, {:login => "error", :password => "error"}
    assert_equal "申请失败", flash[:error]
    assert_redirected_to force_logout_url
    
    post :checkforcelogout, {:login => "outme", :password => "1234"}
    assert_equal "申请成功，请重新登陆", flash[:notice]
    assert_redirected_to root_url
  end

end