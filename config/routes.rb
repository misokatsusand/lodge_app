Rails.application.routes.draw do
  #users_controller
  get 'users/index'
  get 'users/login_form'
  post 'users/login'
  post 'users/logout'
  get 'users/account' => 'users#account_edit'
  post 'users/account_update'
  get 'users/profile/' => 'users#profile_edit'
  post 'users/profile_update'
  resources :users

  #rooms_controller
  root to: 'rooms#top'
  post 'rooms/index'
  get 'rooms/index' => 'rooms#index_all'
  get 'rooms/owned_room'
  get 'rooms/:id/return_confirm/' => 'rooms#return_confirm_reload'
  post 'rooms/:id/return_confirm' => 'rooms#return_confirm'
  resources :rooms

  #books_controller
  get 'books/index'
  get 'books/confirm'
  resources :books
end
