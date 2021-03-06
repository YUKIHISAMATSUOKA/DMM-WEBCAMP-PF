class Shop < ApplicationRecord

  belongs_to :area
  attachment :image
  # validates :name, presence: true
  # validates :image, presence: true

end
