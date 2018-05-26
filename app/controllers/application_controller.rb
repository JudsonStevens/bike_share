class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :admin?, :authorize

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
    redirect_to login_path unless current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    if !current_user
      render file: '/public/404.html'
    elsif !current_user.admin
      redirect_to root_path
    end
  end
end
