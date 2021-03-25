class OrderComment < ApplicationRecord

  belongs_to :customer
  # belongs_to :shop
  belongs_to :order

end
