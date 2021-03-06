class Area < ApplicationRecord

  validates :name, presence: true
  validates :name, length: { maximum: 20}

  has_many :shops, dependent: :destroy

end
