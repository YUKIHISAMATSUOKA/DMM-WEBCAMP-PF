class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :customer
  belongs_to :shop
end
