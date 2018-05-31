class Admin::DashboardsController < Admin::BaseController

  def show
    if current_admin?
      flash.now[:success] = session[:flash_notice] if session[:flash_notice]
      @user = User.find(current_user.id)
      @orders = Order.all
    else
      redirect_to login_path, notice: 'You must log in to see the dashboard'
    end
  end 
end
