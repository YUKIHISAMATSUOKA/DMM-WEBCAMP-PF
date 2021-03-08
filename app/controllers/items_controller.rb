class ItemsController < ApplicationController

  def new
    @item = Item.new
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def index
    @item = Item.new
    @items = Item.all
  end

  def show
  end

  def create
    @item = Item.all
    @item = Item.new(item_params)
    @item.shop_id = current_customer.shop.id
    if @item.save
      redirect_back(fallback_location: root_path)
    else
      render 'new'
    end
  end

  def update
     @item = Item.find(params[:id])
     @item.shop_id = current_customer.shop.id
     if @item.update(item_params)
       redirect_to new_item_path
     else
       render 'edit'
     end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to new_item_path
  end

  private

  def item_params
    params.require(:item).permit(:shop_id, :name, :price, :sale_state, :image, :introduction, :genre, :cook_time)
  end

end
