Rails.application.routes.draw do
  get 'users/new'

  get 'users/show'

  root         'static_pages#home'

  get 'about'  => 'static_pages#about'

  get 'help'   => 'static_pages#help'

  resource :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
