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

      it '漢字のみ: 〇' do
        #FactoryBotにテストワードを記述してバリデーションを設定しているので、テストコードではカタカナ以外の値を入れればよい
        customer = build(:customer, last_name: "a")
        customer.valid?
        # is_expected.to eq false この記述はなぜダメなのかわからない
        expect(customer.errors[:last_name]).to include('は漢字で入力して下さい。')
      end
    end

    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
      it 'ひらがな、カタカナ、漢字のみ: 〇' do
        customer = build(:customer, first_name: "a1")
        customer.valid?
        expect(customer.errors[:first_name]).to include('はひらがな、カタカナ、漢字で入力して下さい。')
      end
    end

    context 'kana_last_nameカラム' do
      it '空欄でないこと' do
        customer.kana_last_name = ''
        is_expected.to eq false
      end
      it 'カタカナのみ: 〇' do
        customer = build(:customer, kana_last_name: "kana")
        customer.valid?
        expect(customer.errors[:kana_last_name]).to include('はカタカナで入力して下さい。')
      end
    end

    context 'kana_first_nameカラム' do
      it '空欄でないこと' do
        customer.kana_last_name = ''
        is_expected.to eq false
      end
      it 'カタカナのみ: 〇' do
        customer = build(:customer, kana_first_name: "あ亜")
        customer.valid?
        expect(customer.errors[:kana_first_name]).to include('はカタカナで入力して下さい。')
      end
    end
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
