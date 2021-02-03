Rails.application.routes.draw do

  get 'finds/find'
  get 'searchs/search'

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  get 'follower/:id' => "relationships#follower", as: "follower"
  get 'followed/:id' => "relationships#followed", as: "followed"

  get 'search' => "searchs#search"
  get 'find' => "finds#find"

  post 'follow/:id' => 'relationships#create', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' # フォロー外す

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users

  resources :finds,only: [:index]
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
end