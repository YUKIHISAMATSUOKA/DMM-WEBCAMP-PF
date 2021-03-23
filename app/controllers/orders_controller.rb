class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @CartItems = current_customer.cart_items

    if @order.save
      #order_itemsの保存
      current_customer.cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.item_id = cart_item.item_id
        @order_item.quantity = cart_item.amount
        @order_item.price = cart_item.item.price
        @order_item.name = cart_item.item.name
        @order_item.order_id = @order.id
        @order_item.save
      end

      # ここから
      # @post.create_notification_comment!(current_user, @comment.id)
      @order.create_notification_order!(current_customer)
      # ここまで
      # @notification = Notification.new
      # @notification.customer_id = current_customer.id
      # @notification.shop_id = @order.shop_id
      current_customer.cart_items.destroy_all
      redirect_to order_complete_path
    else
      flash[:alert] = "注文できませんでした。受取時間の変更をお願いします。"
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @orders = Order.all
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def shop_index
    @orders = Order.all
    @orders = current_customer.shop.orders
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shop_id, :name, :request, :billing_amount, :status, :number, :pick_up_time)
  end
end
