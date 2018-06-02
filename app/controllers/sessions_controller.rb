class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: session_params[:email])
    if !user.nil? && !user.admin? && user.authenticate(session_params[:password])
      log_in(user)
      redirect_to dashboard_path
    elsif !user.nil? && user.admin? && user.authenticate(session_params[:password])
      log_in(user)
      redirect_to admin_dashboard_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    log_out(current_user)
    session[:shopping_cart] = nil
    redirect_to login_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
