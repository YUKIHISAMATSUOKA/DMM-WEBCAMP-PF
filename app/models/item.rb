class Item < ApplicationRecord

  attachment :image
  belongs_to :shop
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25}
  validates :introduction, length: { maximum: 50}
  validates :price, presence: true, format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力して下さい。' }
  validates :cook_time, presence: true

end
