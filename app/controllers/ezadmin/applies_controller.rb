# encoding: utf-8
class Ezadmin::AppliesController < ApplicationController
  before_filter :set_admin_nav_flag
  before_filter :need_admin_login
  
  layout "admin"
  
  def index
    @applies = Apply.paginate(:page => params[:page], :per_page => 20, :order => "id desc")
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @apply = Apply.find(params[:id])
  end

  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
  def set_admin_nav_flag
    @admin_nav_flag = "applies"
  end
end