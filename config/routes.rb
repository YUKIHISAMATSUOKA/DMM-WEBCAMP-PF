Rails.application.routes.draw do

  devise_for :customers
  root to: 'homes#top'
  get 'home/how' => 'homes#how'

  resources :genres, only: [:create, :index, :edit, :update, :destroy]
  get '/genres/:id' => 'genres#index' #editでバリデエラー発生後に、No route matches [GET] "/genres/1"となったので付け足した
  resources :areas, only: [:new, :create, :index, :edit, :update, :destroy]

end
