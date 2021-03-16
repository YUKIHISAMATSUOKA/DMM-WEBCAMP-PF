class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :customer
  belongs_to :shop

  has_many :notifications, dependent: :destroy



  def create_notification_order!(current_customer)
    # すでに「」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and order_id = ? and action = ? ", current_customer.id, shop_id, id, 'order'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        order_id: id,
        visited_id: shop_id,
        action: 'order'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      # if notification.visitor_id == notification.visited_id
        # notification.checked = true
      # end

      notification.save if notification.valid?
    end
  end
end
