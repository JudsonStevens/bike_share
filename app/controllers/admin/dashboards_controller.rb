class Admin::DashboardsController < Admin::BaseController

  def show
    if current_admin?

      if session[:flash_notice]
        flash.now[:success] = session[:flash_notice]
        session[:flash_notice] = nil
      end
      @user = User.find(current_user.id)
      @orders = Order.all
    else
      redirect_to login_path, notice: 'You must log in to see the dashboard'
    end
  end
end
