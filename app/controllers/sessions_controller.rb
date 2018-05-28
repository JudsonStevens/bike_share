class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in(user)
      redirect_to dashboard_path(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end