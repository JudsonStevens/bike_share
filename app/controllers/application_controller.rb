class ApplicationController < ActionController::Base
  before_action :build_temporary_cart
  helper_method :current_user, :logged_in?, :current_admin?, :authorize, :log_in

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
    redirect_to login_path unless current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def build_temporary_cart
    if session[:temporary_shopping_cart].nil?
      session[:temporary_shopping_cart] = {}
    end
  end
end
