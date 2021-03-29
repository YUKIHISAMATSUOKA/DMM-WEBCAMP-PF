class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
    @orders = @orders.page(params[:page]).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @order_comment = OrderComment.new
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.save(validate: false) #これを付けないとpick up timeのエラーで弾かれる
    flash[:notice] = "管理者が注文情報を更新しました。"
    redirect_back(fallback_location: root_path)
  end

  private
  # show.htmlにてorderd_itemの制作ステータスを更新できるようにするため、rderd_item_attributes: [:create_state] を記述しています
  def order_params
    params.require(:order).permit(:state, orderd_item_attributes:[:id, :create_state])
  end
end

