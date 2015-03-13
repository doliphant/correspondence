Rails.application.routes.draw do



  devise_for :users
  resources :users, only: [:update, :show] do
    resources :relationships, only: [:create, :destroy]
  end

  resources :correspondences do
    resources :posts
    resources :comments
    resources :favorites, only: [:create, :destroy]
  end

  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'

end
