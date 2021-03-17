class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :shop
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  #active_notifications：自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true

  # カスタマーログイン時に、退会した人であれば、弾くための記述
  def active_for_authentication?
    super && (self.member_state == true)
  end

end
