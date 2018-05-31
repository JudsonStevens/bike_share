class Admin::DashboardsController < Admin::BaseController
  #respond_to :js, :html

  def show
    if current_admin?


      if session[:flash_notice]
        flash.now[:success] = session[:flash_notice]
        session[:flash_notice] = nil
      end
      @user = User.find(current_user.id)
      @orders = Order.all
      flash.now[:success] = session[:flash_notice] if session[:flash_notice]
      @orders = Order.all

    else
      render 'public/404'
    end
  end
end
