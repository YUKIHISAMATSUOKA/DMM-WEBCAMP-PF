class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        # :omniauthable, omniauth_providers: %i[google_oauth2]

  has_one :shop
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  #active_notifications：自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy


  validates :last_name, presence: true, format: { with: /\A[一-龥]+\z/,  message: 'は漢字で入力して下さい。'}
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/,  message: 'はひらがな、カタカナ、漢字で入力して下さい。'}
  validates :kana_last_name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :kana_first_name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}

  # カスタマーログイン時に、退会した人であれば、弾くための記述
  def active_for_authentication?
    super && (self.member_state == true)
  end


  # def self.without_sns_data(auth)
  #   customer = Customer.where(email: auth.info.email).first

  #     if customer.present?
  #       sns = SnsCredential.create(
  #         uid: auth.uid,
  #         provider: auth.provider,
  #         customer_id: customer.id
  #       )
  #     else
  #       customer = Customer.new(
  #         kana_first_name: auth.info.name,
  #         email: auth.info.email,
  #         password: auth.info.password,
  #       )
  #       sns = SnsCredential.new(
  #         uid: auth.uid,
  #         provider: auth.provider
  #       )
  #     end
  #     return { customer: customer ,sns: sns}
  # end

  # def self.with_sns_data(auth, snscredential)
  #   customer = Customer.where(id: snscredential.customer_id).first
  #   unless customer.present?
  #     customer = Customer.new(
  #       kana_first_name: auth.info.name,
  #       email: auth.info.email,
  #     )
  #   end
  #   return {customer: customer}
  # end

  # def self.find_oauth(auth)
  #   uid = auth.uid
  #   provider = auth.provider
  #   snscredential = SnsCredential.where(uid: uid, provider: provider).first
  #   if snscredential.present?
  #     customer = with_sns_data(auth, snscredential)[:customer]
  #     sns = snscredential
  #   else
  #     customer = without_sns_data(auth)[:customer]
  #     sns = without_sns_data(auth)[:sns]
  #   end
  #   return { customer: customer ,sns: sns}
  # end


end
