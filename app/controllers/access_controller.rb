class AccessController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in, except: [:login, :logout, :attempt_login]

  def login
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      session[:admin] = true
      # mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username

      flash[:success] = "You are logged in"
      redirect_to controller: :works, action: :index
    else
      flash[:error] = "Invalid username/passowrd"
      redirect_to action: :login
    end
  end

  def logout
    # mark user as logged out
    session[:user_id] = nil
    session[:username] = nil

    flash[:success] = "Logged out"
    redirect_to action: :login
  end

end
