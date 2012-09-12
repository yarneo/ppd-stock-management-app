class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_globals
  helper_method :current_user

  def init_globals
	@storages = Storage.order("name")
	@storage_id = 0
  end

private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end



protected 
   
  def logged_in? 
    unless session[:user_id] 
      redirect_to log_in_path 
      return false 
    else 
      return true 
    end 
  end

end