class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     flash[:notice] = "管理者がアカウント情報を変更しました"
     redirect_to admin_customer_path(@customer)
    else
     render :edit
    end
  end

  def active_for_authentication?
    super && (self.member_state == false)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name, :kana_last_name, :kana_first_name, :email, :member_state)
  end

end
