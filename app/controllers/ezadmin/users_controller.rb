# encoding: utf-8
class Ezadmin::UsersController < ApplicationController
  before_filter :set_admin_nav_flag
  before_filter :need_admin_login
  
  layout "admin"
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 20, :order => "id desc")
    respond_to do |format|
      format.html
    end
  end
  
  def online
    @users = User.paginate(:conditions => ["online = ?", true], :page => params[:page], :per_page => 20, :order => "id desc")
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = '添加成功'
        format.html { redirect_to(ezadmin_user_url(@user)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = '编辑成功'
        format.html { redirect_to(ezadmin_user_url(@user)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      flash[:notice] = '删除成功'
      format.html { redirect_to(ezadmin_users_url) }
    end
  end
  
  def kickout
    @id = params[:id]
    User.update(@id, :online => false)
    respond_to do |format|
      format.js
    end
  end
  
  private
  def set_admin_nav_flag
    @admin_nav_flag = "users"
  end
end