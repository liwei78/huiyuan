# encoding: utf-8
require 'tool_box'
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def loggin?
    (session[:signcode].present?||cookies[:signcode].present?) ? true : false
  end
  
  private
  
  def need_admin_login
    unless ToolBox.admin_login?(session[:admin_key])
      flash[:error] = '管理员未登录'
      redirect_to ezadmin_login_url
    end
  end
  
  def need_user_login
    if !loggin?
      flash[:notice] = "请登录"
      redirect_to root_url
    else
      @user = User.find(session[:user_id]||cookies[:user_id])
      if @user.offline
        session.delete(:signcode)
        session.delete(:user_id)
        cookies.delete(:signcode)
        cookies.delete(:user_id)
        redirect_to root_url
      end
    end 
  end
  
end
