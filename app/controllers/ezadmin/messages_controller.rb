# encoding: utf-8
class Ezadmin::MessagesController < ApplicationController
  before_filter :set_admin_nav_flag
  before_filter :need_admin_login
  
  layout "admin"
  
  def index
    @messages = Message.paginate(:page => params[:page], :per_page => 10, :order => "id desc")
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      if @message.save
        flash[:notice] = '添加成功'
        format.html { redirect_to(ezadmin_message_url(@message)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = '编辑成功'
        format.html { redirect_to(ezadmin_message_url(@message)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      flash[:notice] = '删除成功'
      format.html { redirect_to(ezadmin_messages_url) }
    end
  end
  
  def publish
    @message = Message.find(params[:id])
    User.find_each(:batch_size => 10) do |user|
      UserMessage.create(:user_id => user.id, :title => @message.title, :content => @message.content)
    end if @message
    @message.update_attribute(:publish, true)
    respond_to do |format|
      flash[:notice] = '发布成功。所有用户可见该信息。'
      format.html { redirect_to(ezadmin_messages_url) }
    end
  end
  
  private
  def set_admin_nav_flag
    @admin_nav_flag = "messages"
  end
end