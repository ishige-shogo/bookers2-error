Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  get 'follower/:id' => "relationships#follower", as: "follower"
  get 'followed/:id' => "relationships#followed", as: "followed"

  post 'follow/:id' => 'relationships#create', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' # フォロー外す


  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

end