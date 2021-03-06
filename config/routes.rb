Rails.application.routes.draw do

  root         'static_pages#home'

  get 'about'  => 'static_pages#about'

  get 'help'   => 'static_pages#help'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'
  get 'rolify' => 'users#rolify'
  get 'accept' => 'requests#accept'
  get 'maintainer' => 'users#maintainer'
  get 'assign' => 'requests#assign'
  
  delete 'logout' => 'sessions#destroy'
  get 'dashboard'  => 'users#dashboard'
  get 'assign' => 'requests#assign'

  resources :users

  resources :account_activations, only: [:edit]

  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :requests

  resources :comments, only: [:new, :create,:show, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
