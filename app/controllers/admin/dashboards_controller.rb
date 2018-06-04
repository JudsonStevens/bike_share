class Admin::DashboardsController < Admin::BaseController
  def show
    if session[:flash_notice]
      flash.now[:success] = session[:flash_notice]
      session[:flash_notice] = nil
    end
    @user = User.find(current_user.id)
    @orders = Order.all
    @personal_orders = @user.orders
    flash.now[:success] = session[:flash_notice] if session[:flash_notice]
    @ordered = Order.ordered.count
    @cancelled = Order.cancelled.count
    @completed = Order.completed.count
    @paid = Order.paid.count
    if params[:type] == 'cancelled'
      @orders = Order.cancelled
    elsif params[:type] == 'completed'
      @orders = Order.completed
    elsif params[:type] == 'ordered'
      @orders = Order.ordered
    elsif params[:type] == 'paid'
      @orders = Order.paid
    end
  end
end
