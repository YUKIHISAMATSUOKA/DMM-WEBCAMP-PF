class Payment < ApplicationRecord

  attachment :image
  validates :name, presence: true
  validates :name, length: { maximum: 20}
  validates :genre, presence: true
  validates :image, presence: true

  belongs_to :shop
end
