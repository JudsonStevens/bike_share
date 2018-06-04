class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    if @order.nil?
      render file: 'public/404'
    else
      @items = @order.item_orders.map { |item_order| { Item.find(item_order.item_id) => item_order.quantity } }
      @order_total = @items.map { |item_hash| item_hash.keys.first.price * item_hash.values.first }.sum
      @purchaser = @order.user
    end
  end

  def create
    order = current_user.orders.create(order_params)
    params[:items].each do |item_id, quantity|
      order.item_orders.create(item_id: item_id, quantity: quantity)
    end
    if current_admin?
      session[:flash_notice] = params[:flash_notice]
      session[:shopping_cart] = nil
      redirect_to admin_dashboard_path
      return
    else
      session[:flash_notice] = params[:flash_notice]
      session[:shopping_cart] = nil
      redirect_to dashboard_path
      return
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
