class Admin::ItemsController < Admin::BaseController

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:success] = "You have updated #{item.title}"
    end

    redirect_to admin_bike_shop_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :price, :image, :description)
  end

end
