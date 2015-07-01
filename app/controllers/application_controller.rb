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

  def get_hit_counts
    @hits = HitCount.find_by_cat('all').hits
    @unique_hits = HitCount.find_by_cat('unique').hits
    @guest_visited = session[:visited]
  end
end
