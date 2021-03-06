class ShopsController < ApplicationController

  def index
  end

  def edit
  end

  def show
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to shop_path(@shop)
    else
      render 'new'
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:customer_id, :area_id, :name, :introduction, :image, :status, :address, :telephone_number, :post_code, :email)
  end


end
