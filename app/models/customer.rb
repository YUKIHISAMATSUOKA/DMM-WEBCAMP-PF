class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :post_code, presence: true
  validates :post_code, length: { is: 7 }
  validates :address, presence: true
  validates :telephone_number, presence: true

  # カスタマーログイン時に、退会した人であれば、弾くための記述
  def active_for_authentication?
    super && (self.member_state == true)
  end

end
