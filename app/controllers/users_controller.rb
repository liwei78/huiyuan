class UsersController < ApplicationController
  
  before_filter :need_user_login
  
  def show
    @unread = @user.unread_count
    @messages = UserMessage.paginate(
      :conditions    => ["user_id = ? and created_at >= ?", @user.id, 3.days.ago], 
      :page          => params[:page], 
      :per_page      => SITE_SETTINGS["list_per_page"])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def find
    @unread = @user.unread_count
    case params[:day]
    when "today"
      condition = ["created_at >= ?", Date.today]
    when "3days"
      condition = ["created_at >= ?", 3.days.ago]
    when "7days"
      condition = ["created_at >= ?", 7.days.ago]
    when "1month"
      condition = ["created_at >= ?", 1.month.ago]
    when "6month"
      condition = ["created_at >= ?", 6.month.ago]
    when "all"
      condition = ""
    else
      condition = ["created_at >= ?", Date.today]
    end
    @messages = @user.user_messages.paginate(
      :conditions => condition, 
      :page     => params[:page], 
      :per_page => SITE_SETTINGS["list_per_page"])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
