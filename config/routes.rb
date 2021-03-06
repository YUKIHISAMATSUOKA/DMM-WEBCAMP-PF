Rails.application.routes.draw do

  devise_for :customers
  root to: 'homes#top'
  get 'home/how' => 'homes#how'
  get 'home/question' => 'homes#question'

  resources :genres, only: [:create, :index, :edit, :update, :destroy]
  get '/genres/:id' => 'genres#index' #editでバリデエラー発生後に、No route matches [GET] "/genres/1"となったので付け足した
  resources :areas, only: [:new, :create, :index, :edit, :update, :destroy]

  resources :customers, only: [:index, :show, :edit, :update]
  get 'customer/exit' => 'customers#exit'
  put "/customers/:id/hide" => "customers#hide", as: 'customers_hide'

end
