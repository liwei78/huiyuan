# encoding: utf-8
require 'tool_box'
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def get_current_user
    User.find(session[:user_id]||cookies[:user_id]) if loggin?
  end
  
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
    unless loggin?
      flash[:notice] = "请登录"
      redirect_to root_url
    end 
  end
  
end
