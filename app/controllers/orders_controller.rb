class OrdersController < ApplicationController

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
        @order_item.order_id = @order.id
        @order_item.save
      end
      current_customer.cart_items.destroy_all
      redirect_to order_complete_path
    else
      flash[:alert] = "注文できませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @orders = Order.all
    @orders = current_customer.orders
    @first = 1 #each文,最初の1回のみのトリガーに使用するため
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :request, :billing_amount, :status, :number, :pick_up_time)
  end
end
