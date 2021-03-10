class Shop < ApplicationRecord

  attachment :image
  belongs_to :area
  belongs_to :customer
  # 現状使用していない　has_many :payments, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 30}
  validates :image_id, presence: true
  validates :introduction, length: { maximum: 100}
  validates :post_code, presence: true
  validates :post_code, length: { is: 7 }
  validates :address, presence: true
  validates :telephone_number, presence: true

end