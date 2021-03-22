Rails.application.routes.draw do

  get 'inquiry/index'
  get 'inquiry/confirm'
  get 'inquiry/thanks'
  devise_for :customers
    # controllers: {
    # sessions: 'customers/sessions',
    # registrations: "customers/registrations",
    # omniauth_callbacks: 'customers/omniauth_callbacks'
  # }



  root to: 'homes#top'
  get 'home/how' => 'homes#how'
  get 'home/question' => 'homes#question'

  resources :genres, only: [:create, :index, :edit, :update, :destroy]
  get '/genres/:id' => 'genres#index' #editでバリデエラー発生後に、No route matches [GET] "/genres/1"となったので付け足した
  resources :areas, only: [:new, :create, :index, :edit, :update, :destroy]
  get 'areas/area1' => 'areas/area1'
  get 'areas/area2' => 'areas/area2'
  get 'areas/area3' => 'areas/area3'
  get 'areas/area4' => 'areas/area4'
  get 'areas/area5' => 'areas/area5'
  get 'areas/area6' => 'areas/area6'
  get 'areas/area7' => 'areas/area7'
  get 'areas/area8' => 'areas/area8'

  resources :customers, only: [:index, :show, :edit, :update]
  get 'customer/exit' => 'customers#exit'
  put "/customers/:id/hide" => "customers#hide", as: 'customers_hide'

  resources :payments, only: [:index, :edit, :update, :create, :destroy]

  resources :shops, only: [:new, :create, :index, :edit, :update, :destroy, :show]
  get 'shop/exit' => 'shops#exit'

  resources :items, only: [:new, :create, :edit, :update, :destroy, :show]

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

  resources :notifications, only: [:index, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end

  root  'inquiry#index'
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

end