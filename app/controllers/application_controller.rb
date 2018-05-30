class ApplicationController < ActionController::Base
  before_action :build_cart
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

  rescue_from ActionController::RoutingError do |exception|
    logger.error 'Routing error occurred'
    render file: 'public/404.html', status: 404
  end

  rescue_from AbstractController::ActionNotFound do |exception|
    logger.error 'Routing error occurred'
    render file: 'public/404.html', status: 404
  end

  rescue_from ActionView::MissingTemplate do |exception|
    logger.error exception.message
    render file: 'public/404.html', status: 404
  end

  def action_missing(m, *args, &block)
    logger.error(m)
    redirect_to '/*path'
  end
end
