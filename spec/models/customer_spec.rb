 require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_customer) { create(:customer) }
    let(:customer) { build(:customer) }

    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end

      it 'last_nameが漢字のみ: 〇' do
        #FactoryBotにカタカナの記述を行ってバリデーションを設定しているので、テストコードではカタカナ以外の値を入れればよい
        customer = build(:customer, last_name: "ああああ")
        customer.valid?
        is_expected.to eq false
      end
    end

    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
    end

    context 'kana_last_nameカラム' do
      it '空欄でないこと' do
        customer.kana_last_name = ''
        is_expected.to eq false
      end

      it 'kana_last_nameがカタカナのみ: 〇' do
        #FactoryBotにカタカナの記述を行ってバリデーションを設定しているので、テストコードではカタカナ以外の値を入れればよい
        customer = build(:customer, kana_last_name: "kana")
        customer.valid?
        expect(customer.errors[:kana_last_name]).to include('はカタカナで入力して下さい。')
      end


    end

    context 'kana_first_nameカラム' do
      it '空欄でないこと' do
        customer.kana_first_name = ''
        is_expected.to eq false
      end
    end

      # it '漢字とアルファベットであること: カタカナ、ひらがな、数字などは×' do
      #   customer.last_name = '亜aア'
      #   is_expected.to eq true
      # end

      # it '2文字以上であること: 2文字は〇' do
      #   user.name = Faker::Lorem.characters(number: 2)
      #   is_expected.to eq true
      # end

      # it '20文字以下であること: 20文字は〇' do
      #   user.name = Faker::Lorem.characters(number: 20)
      #   is_expected.to eq true
      # end
      # it '20文字以下であること: 21文字は×' do
      #   user.name = Faker::Lorem.characters(number: 21)
      #   is_expected.to eq false
      # end

    # context 'member_stateカラム' do
    #   it '50文字以下であること: 50文字は〇' do
    #     customer.member_state = Faker::Lorem.characters(number: 50)
    #     is_expected.to eq true
    #   end
    #   it '50文字以下であること: 51文字は×' do
    #     user.introduction = Faker::Lorem.characters(number: 51)
    #     is_expected.to eq false
    #   end
    # end
  end

  describe 'アソシエーションのテスト' do
    context 'Orderモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:orders).macro).to eq :has_many
      end
    end

    context 'Cart_itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:cart_items).macro).to eq :has_many
      end
    end

    context 'Order_commentsモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:order_comments).macro).to eq :has_many
      end
    end

    context '自分からの通知との関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end

    context 'Shopとの関係' do
      it '1:1となっている' do
        expect(Customer.reflect_on_association(:shop).macro).to eq :has_one
      end
    end
  end
end
