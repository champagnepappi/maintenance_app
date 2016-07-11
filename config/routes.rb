Rails.application.routes.draw do
 

  root         'static_pages#home'

  get 'about'  => 'static_pages#about'

  get 'help'   => 'static_pages#help'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'
  
  delete 'logout' => 'sessions#destroy'

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
