class CartController < ApplicationController
  def index
    @items = Item.where(id: session[:shopping_cart].keys)
    @order_total = @items.map { |item| item.price * session[:shopping_cart][item.id.to_s].to_i }.sum
  end

  def update
    if session[:shopping_cart][params[:item][:item_id]].nil?
      session[:shopping_cart][params[:item][:item_id]] = (params[:item][:quantity]).to_i
      flash[:success] = "You have added #{Item.find(params[:item][:item_id]).title} to your cart!"
    else
      session[:shopping_cart][params[:item][:item_id]] = (params[:item][:quantity]).to_i
      flash[:success] = "You have updated your cart!"
    end
    redirect_back(fallback_location: bike_shop_path)
  end

  def destroy
    session[:shopping_cart].delete(params[:item][:item_id])
    item = Item.find(params[:item][:item_id])
    flash[:success] = %Q[You have removed #{(view_context.link_to "#{item.title}", item_path(item))} from your cart!]
    redirect_back(fallback_location: bike_shop_path)
  end
end