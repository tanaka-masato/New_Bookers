Rails.application.routes.draw do
  # get 'homes/about'
  #get 'users/show'
  devise_for :users
  resources :books
  
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:show, :index, :edit, :update]
end
