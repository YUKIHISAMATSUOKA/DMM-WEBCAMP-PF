class NotificationsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @notifications = current_customer.shop.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    @notifications = current_customer.shop.passive_notifications
    # @notifications_checked = @notifications.where(checked: 'true')
    # if @notifications_checked.present?
    if @notifications.destroy_all
      redirect_to notifications_path
    end
  end


end
