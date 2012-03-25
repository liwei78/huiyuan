# encoding: utf-8
require 'tool_box'
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def need_admin_login
    unless ToolBox.admin_login?(session[:admin_key])
      flash[:error] = '管理员未登录'
      redirect_to login_url
    end
  end
end
