require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  end

  describe 'カスタマー新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
    end
    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[last_name]', with: '令和'
        fill_in 'customer[first_name]', with: 'みちこ'
        fill_in 'customer[kana_last_name]', with: 'レイワ'
        fill_in 'customer[kana_first_name]', with: 'ミチコ'

        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end
      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
    end
  end

  describe 'カスタマーログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
       it 'emailフォームは表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end
    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[name]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end
    end
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end
      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end
