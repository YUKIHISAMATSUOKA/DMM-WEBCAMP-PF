Rails.application.routes.draw do

  devise_for :customers
  root to: 'homes#top'
  get 'home/how' => 'homes#how'
  get 'home/question' => 'homes#question'

  resources :genres, only: [:create, :index, :edit, :update, :destroy]
  get '/genres/:id' => 'genres#index' #editでバリデエラー発生後に、No route matches [GET] "/genres/1"となったので付け足した
  resources :areas, only: [:new, :create, :index, :edit, :update, :destroy]
  get 'areas/shinkoiwa' => 'areas/shinkoiwa'

  resources :customers, only: [:index, :show, :edit, :update]
  get 'customer/exit' => 'customers#exit'
  put "/customers/:id/hide" => "customers#hide", as: 'customers_hide'

  resources :payments, only: [:index, :edit, :update, :create, :destroy]

  resources :shops, only: [:new, :create, :index, :edit, :update, :destroy, :show]
  get 'shop/exit' => 'shops#exit'

  resources :items

  resources :cart_items, only: [:index, :create, :update, :destroy] do
    #collectionはリソース全体に対するアクションを定義します
    collection do
      delete 'destroy_all'
    end
  end

  resources :orders, only: [:create, :index, :show]
  get 'order/shop_index' => 'orders#shop_index'
  get 'order/confirm' => 'orders#confirm'
  # order/complete.htmlで注文確定のform_withをするのでPOSTにする
  get 'order/complete' => 'orders#complete'

  resources :notifications, only: :index
end