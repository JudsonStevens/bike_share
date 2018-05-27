class CartController < ApplicationController
  def index
    @items = Item.where(id: session[:temporary_shopping_cart].keys)
  end

  def update
  end
end