class UsersController < ApplicationController
  before_filter :need_user_login
  def show
    @user = get_current_user
    @messages = @user.user_messages.paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def notice
    @user = get_current_user
    respond_to do |format|
      format.js
    end
  end

end
