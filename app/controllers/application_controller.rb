class ApplicationController < ActionController::Base
  before_action :build_cart
<<<<<<< HEAD
<<<<<<< HEAD
  helper_method :current_user, :logged_in?, :authorize, :log_in, :current_admin?, :log_out
=======
  helper_method :current_user, :logged_in?, :current_admin?, :authorize, :log_in
>>>>>>> fixed inital merge conflicts
=======
  helper_method :current_user, :logged_in?, :current_admin?, :authorize, :log_in
>>>>>>> 520485bffd18c683fc2b7961fa727e13a920053a

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

  def log_in(user)
    session[:user_id] = user.id
  end

  def build_cart
    if session[:shopping_cart].nil?
      session[:shopping_cart] = {}
    end
  end

  def log_out(user)
    session.delete(:user_id)
    @current_user = nil
  end
end
