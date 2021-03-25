class OrderCommentsController < ApplicationController

  def create
    @order = Order.find(params[:order_id])
    @order_comment = current_customer.order_comments.new(order_comment_params)
    @order_comment.order_id = @order.id
    @order_comment.save
    # 非同期化に伴い削除
    # redirect_to order_path(@order)
  end

  def destroy
    # OrderComment.find_by(id: params[:id], order_id: params[:order_id]).destroy
    @order = Order.find(params[:order_id])
    @order_comment = @order.order_comments.find(params[:id])
    @order_comment.destroy
    # 非同期化に伴い削除
    # redirect_to order_path(params[:order_id])
  end

  private

  def order_comment_params
    params.require(:order_comment).permit(:comment)
  end

end
