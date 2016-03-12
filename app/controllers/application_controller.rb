# Sets the base framework for all controllers
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user , :require_user  ## allows method to be called in views, not just other controllers
  include CanCan::ControllerAdditions
  before_action :check_member_status

  def home
    render "home"
  end


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def check_member_status
    current_user.nil? || current_user.update_status
  end

end
