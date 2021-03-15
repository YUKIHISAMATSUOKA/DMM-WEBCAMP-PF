class CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @sum = 0 #合計金額を計算するので初期値は0
    @first = 1 #each文,最初の1回のみのトリガーに使用するため
  end

  def create
    # もし、カート内の既存の商品のショップIDと、新しく追加する商品のショップIDが異なるのならば、
    if current_customer.cart_items.joins(:item).where.not(items: {shop_id: Item.find(params[:cart_item][:item_id]).shop_id}).any?
      # render :text => "data-confirm" => "本当に削除しますか？"
      current_customer.cart_items.destroy_all
      flash[:notice] = "別のお店の商品を追加したため、カート内商品を入れ替えました"
    end
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
      redirect_to cart_items_path
    else
      flash[:alert] = "個数を選択してください"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_back(fallback_location: root_path)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    CartItem.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def find_or_create_by(attributes, &block)
    find_by(attributes) || create(attributes, &block)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

end
