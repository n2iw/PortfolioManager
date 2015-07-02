class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def confirm_logged_in
    unless session[:user_id]
      flash[:alert] = 'Please loggin first'
      redirect_to controller: :access, action: :login
      return false
    else
      return true
    end
  end

  def page_name
    if action_name == 'show' || action_name == 'show_process'
      "#{@work.id}"
    else
      action_name
    end
  end
end
