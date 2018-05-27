class CartController < ApplicationController
  def index
    @items = Item.where(id: session[:shopping_cart].keys)
  end

  def update
    session[:shopping_cart][params[:cart][:item_id]] = params[:cart][:quantity]
  end
end