class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { redirect_to dashboard_path(@user), notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    if current_user
      flash.now[:success] = session[:flash_notice] if session[:flash_notice]
      @user = User.find(current_user.id)
      @orders = @user.orders
    else
      redirect_to login_path, notice: 'You must log in to see the dashboard'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :address, :password)
  end
end
