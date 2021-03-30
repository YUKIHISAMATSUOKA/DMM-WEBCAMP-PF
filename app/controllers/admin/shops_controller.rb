class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  # before_action :correct_admin, only:[:edit]

  def index
    # @orders = Order.all
    # @orders = current_customer.orders
    @shops = Shop.all
    @shops = @shops.page(params[:page]).reverse_order
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def show
    @shop = Shop.find(params[:id])
    # 必ず複数形にすること、複数の情報が入っているので/ ここの３つのwhereはview画面でitemの並び替えをしているため記述している
    @items = @shop.items
    @items_main = @items.where(genre: '1')
    @items_side = @items.where(genre: '2')
    @items_drink = @items.where(genre: '3')
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:notice] = "管理者がお店情報を変更しました"
      redirect_to admin_shop_path(@shop)
    else
      render 'edit'
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    flash[:alert] = "管理者がショップを削除しました"
    redirect_to admin_customers_path
  end

  # def exit
  #   @shop = current_customer.shop
  # end

  private
  def shop_params
    params.require(:shop).permit(:customer_id, :area_id, :name, :introduction, :image, :status, :address, :telephone_number, :post_code, :email )
  end

  # 編集画面でのURL直打ち対策
  # def correct_customer
  #   @shop = Shop.find(params[:id])
  #   unless @shop.customer.id == current_customer.id
  #     redirect_to shop_path(@shop)
  #   end
  # end

end
