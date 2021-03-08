class Item < ApplicationRecord

  attachment :image
  belongs_to :shop

  validates :name, presence: true
  validates :name, length: { maximum: 30}
  validates :introduction, length: { maximum: 50}
  validates :price, presence: true
  validates :cook_time, presence: true

  # enum cook_time:[:"5分", :"10分", :"15分", :"20分", :"25分", :"30分"]
end
