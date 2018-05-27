class CartController < ApplicationController
  def index
    @items = Item.where(id: session[:shopping_cart].keys)
  end

  def update
    session[:shopping_cart][params[:item][:item_id]] = params[:item][:quantity]
    flash[:success] = "You have added #{Item.find(params[:item][:item_id]).title} to your cart!"
    redirect_back(fallback_location: bike_shop_path)
  end
end