class Admin::DashboardsController < Admin::BaseController

  def update
    order = Order.find(params[:id])
    
  end

end
