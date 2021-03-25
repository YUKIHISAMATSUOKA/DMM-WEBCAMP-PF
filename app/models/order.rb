class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :order_comments, dependent: :destroy
  belongs_to :customer
  belongs_to :shop

  validates :request, length: { maximum: 50}
  validate :start_end_check

  enum status: {"注文確認中": 0, "調理中": 1, "商品完成": 2, "受取り済み": 3}

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

  #　 なんでこの記述で動作するのかわかりません。受取時間が、現在の時間よりも過ぎているとorder.createできない。
  def start_end_check
    errors.add(:pick_up_time, "の日付を正しく記入してください。") unless
    # string型に変換しないと、比較できなかった。
    Time.zone.now.to_s(:time) < self.pick_up_time.to_s(:time)
  end

end
