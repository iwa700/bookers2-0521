Rails.application.routes.draw do
  
  
  
  
  devise_for :users
  
  # devise_scope :user do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
 
  root 'homes#top'
  
  get 'home/about' => 'homes#about' 
  

  resources :books
  
  resources :users, only: [:show, :edit, :update , :index, :create]
  
end
