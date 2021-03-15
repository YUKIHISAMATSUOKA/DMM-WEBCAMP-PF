class ShopsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only:[:edit]

  def index
    @orders = Order.all
    @orders = current_customer.orders
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

  def new
    @shop = Shop.new
    # @payments = Payment.all
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.customer_id = current_customer.id
    if @shop.save
      flash[:notice] = "お店を登録しました"
      redirect_to shop_path(@shop)
    else
      render 'new'
    end
  end

  def update
    @shop = Shop.find(params[:id])
    @shop.customer_id = current_customer.id
    if @shop.update(shop_params)
      flash[:notice] = "お店情報を変更しました"
      redirect_to shop_path(@shop)
    else
      render 'edit'
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    flash[:alert] = "ショップを削除しました"
    redirect_to customers_path
  end

  def exit
    @shop = current_customer.shop
  end


  private

  def shop_params
    params.require(:shop).permit(:customer_id, :area_id, :name, :introduction, :image, :status, :address, :telephone_number, :post_code, :email, payment_ids:[])
  end

  # 編集画面でのURL直打ち対策
  def correct_customer
    @shop = Shop.find(params[:id])
    unless @shop.customer.id == current_customer.id
      redirect_to shop_path(@shop)
    end
  end


end
