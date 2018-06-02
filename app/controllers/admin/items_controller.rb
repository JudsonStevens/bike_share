class Admin::ItemsController < Admin::BaseController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new(params[:id])
  end

  def create
    params[:item][:image] = "https://images-na.ssl-images-amazon.com/images/I/41gvKImzHqL.jpg" if params[:item][:image] == ""
    item = Item.new(item_params)
    # require 'pry'; binding.pry
    if item.save
      flash[:success] = "#{item.title} has been created"
      redirect_to item_path(item)
    elsif params[:item][:price].to_f <= 0
      flash[:error] = "Item needs a price greater than zero"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Item must have unique title"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    params["item"]["is_retired?"] = (params["item"]["is_retired?"])
    item = Item.find(params[:id])
    if item.update(item_params)
      if params["item"]["is_retired?"] == 'false'
        flash[:success] = "You have reactivated #{item.title}"
      elsif params["item"]["is_retired?"] == 'true'
        flash[:success] = "You have retired #{item.title}"
      else
        flash[:success] = "You have updated #{item.title}"
      end
    end
    redirect_to admin_bike_shop_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :price, :image, :description, :is_retired?)
  end

end
