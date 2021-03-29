class Customer::ItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only:[:edit]

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def create
    @item = Item.all
    @item = Item.new(item_params)
    @item.shop_id = current_customer.shop.id
    if @item.save
      # redirect_back(fallback_location: root_path)
      redirect_to shop_path(current_customer.shop)
      flash[:notice] = "商品を登録しました"
    else
      render 'new'
    end
  end

  def update
     @item = Item.find(params[:id])
     @item.shop_id = current_customer.shop.id
     if @item.update(item_params)
       redirect_to shop_path(current_customer.shop)
       flash[:notice] = "商品情報を更新しました"
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

  # 編集画面でのURL直打ち対策
  def correct_customer
    @item = Item.find(params[:id])
    unless @item.shop.id == current_customer.shop.id
      redirect_to item_path(@item)
    end
  end

end
