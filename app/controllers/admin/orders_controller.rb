class Admin::OrdersController < Admin::BaseController

  def update
    params["order"]["status"] = (params["order"]["status"])
    order = Order.find(params[:id])
    if order.update(order_params)
      flash[:success] = "You have updated the order status!"
    end
    redirect_back(fallback_location: admin_dashboard_path)
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end
end
