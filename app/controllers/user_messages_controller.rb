# encoding: utf-8
class UserMessagesController < ApplicationController
  before_filter :need_user_login
  def show
    @unread = @user.unread_count
    @message = @user.user_messages.find(params[:id])
    @message.readit if @message
    @ori_message = Message.find_by_id(@message.ori_message_id)
  end
  
  def readall
    # 2012-4-4 fix update_all
    UserMessage.where(['user_id = ?', @user.id]).each(&:readit)
    flash[:notice] = "全部标记为已读"
    redirect_to @user
  end
end