#encoding: utf-8
require "tool_box"

class Ezadmin::DashboardController < ApplicationController
  before_filter :need_admin_login, :only => ["index"]
  
  def login
    render :layout => false
  end

  def checklogin
    succ = ToolBox.check_login(params[:account], params[:password])
    respond_to do |format|
      if succ
        session[:admin_key] = ToolBox.admin_key
        format.html {redirect_to root_url}
      else
        flash[:error] = '登录失败'
        format.html {redirect_to login_url}
      end
    end
  end
  
  def index
    @admin_nav_flag = "index"
  end
  
  def logout
    session.delete(:admin_key)
    redirect_to login_url
  end
  
end
