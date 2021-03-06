class PaymentsController < ApplicationController

  def index
    @payments = Payment.all
    @payment = Payment.new
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def create
    @payments = Payment.all
    @payment = Payment.new(payment_params)
    #@payment.shop_id = shop.id
    if @payment.save
      redirect_to payments_path
    else
      render 'index'
    end
  end

  def update
    @payment = Payment.find(params[:id])
    if @payment.update(payment_params)
      redirect_to payments_path
    else
      render 'edit'
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    redirect_to payments_path
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :image, :genre)
  end
end
