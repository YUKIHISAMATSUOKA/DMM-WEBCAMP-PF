module NotificationsHelper

  def unchecked_notifications
    @notifications = current_customer.shop.passive_notifications.where(checked: false)
  end
end
