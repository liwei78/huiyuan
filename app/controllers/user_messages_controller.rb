# encoding: utf-8
class UserMessagesController < ApplicationController
  before_filter :need_user_login
  def show
    @user = get_current_user
    @message = @user.user_messages.find(params[:id])
    @message.update_attribute(:read, true) if @message
    @ori_message = Message.find(@message.ori_message_id)
  end
  
  def readall
    @user = get_current_user
    @user.user_messages.each(&:readit) if @user.user_messages.present? 
    flash[:notice] = "全部标记为已读"
    redirect_to @user
  end
end