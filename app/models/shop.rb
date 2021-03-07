class Shop < ApplicationRecord

  belongs_to :area
  attachment :image
  # validates :name, presence: true
  # validates :image, presence: true

  belongs_to :customer
  has_many :payments, dependent: :destroy

end