# encoding: utf-8
class MainController < ApplicationController
  def index
    
  end
  
  def login
    
  end
  
  def checklogin
    user = User.authenticate(params[:login], params[:password])
    respond_to do |format|
      if user
        if params[:remember_me] == "true"
          cookies[:signcode] = {
            :value => user.signcode,
            :expires => 14.days.from_now
          }
          cookies[:user_id] = {
            :value => user.id,
            :expires => 14.days.from_now
          }
        else
          session[:signcode]  = user.signcode
          session[:user_id]  = user.id
        end
        format.html {redirect_to user}
      else
        flash[:error] = "登录失败"
        format.html {redirect_to root_url}
      end
    end
  end
  
  def logout
    session.delete(:signcode)
    cookies.delete(:signcode)
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end
  
end