# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :find_user
  before_filter :check_for_logged_in_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def check_for_logged_in_user
    return if RAILS_ENV == 'test'
    return if self.controller_name == 'users' && ['login', 'authenticate'].include?(self.action_name)
    return if self.controller_name == "landing"
    redirect_to login_users_path unless @current_user
  end

  def find_user
    if RAILS_ENV == 'test'
      @current_user = User.last || User.new
    else
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end
end
