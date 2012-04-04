# encoding: utf-8
class Ezadmin::MessagesController < ApplicationController
  before_filter :set_admin_nav_flag
  before_filter :need_admin_login
  
  layout "admin"
  
  def index
    @messages = Message.paginate(:page => params[:page], :per_page => 20, :order => "id desc")
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
        
        files = params[:photos].present? ? params[:photos][:file] : []
        unless files.blank?
          files.each do |file|
            Photo.create(:file => file, :message_id => @message.id) if file.present?
          end
        end
        
        if params[:message][:publish] == "1"
          User.find_each(:batch_size => 10) do |user|
            UserMessage.create(:user_id => user.id, :ori_message_id => @message.id, :title => @message.title, :content => @message.content)
          end if @message
          @message.update_attribute(:publish, true)
          flash[:notice] = '添加并发布成功'
        else
          flash[:notice] = '添加成功'
        end
        
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
        
        files = params[:photos].present? ? params[:photos][:file] : []
        unless files.blank?
          files.each do |file|
            Photo.create(:file => file, :message_id => @message.id) if file.present?
          end
        end
        
        if params[:message][:publish] == "1"
          User.find_each(:batch_size => 10) do |user|
            UserMessage.create(:user_id => user.id, :ori_message_id => @message.id, :title => @message.title, :content => @message.content)
          end if @message
          @message.update_attribute(:publish, true)
          flash[:notice] = '编辑并发布成功'
        else
          flash[:notice] = '编辑成功'
        end
        
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
      UserMessage.create(:user_id => user.id, :ori_message_id => @message.id, :title => @message.title, :content => @message.content)
    end if @message
    @message.update_attribute(:publish, true)
    respond_to do |format|
      flash[:notice] = '发布成功。所有用户可见该信息。'
      format.html { redirect_to(ezadmin_messages_url) }
    end
  end
  
  def del_photo
    message = Message.find(params[:id])
    photo = message.photos.find(params[:pid])
    photo.destroy
    redirect_to ezadmin_message_url(message)
  end
  
  private
  def set_admin_nav_flag
    @admin_nav_flag = "messages"
  end
end