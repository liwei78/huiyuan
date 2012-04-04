# encoding: utf-8
class UserMessagesController < ApplicationController
  before_filter :need_user_login
  def show
    @user = get_current_user
    @message = @user.user_messages.find(params[:id])
    @message.update_attribute(:read, true) if @message
    @ori_message = Message.find_by_id(@message.ori_message_id)
  end
  
  def readall
    @user = get_current_user
    # 2012-4-4 fix update_all
    # @user.user_messages.each(&:readit) if @user.user_messages.present? 
    UserMessage.where('user_id = ? and read = ?', @user.id, false).update_all(:read => true) if @user.user_messages.present? 
    flash[:notice] = "全部标记为已读"
    redirect_to @user
  end
end