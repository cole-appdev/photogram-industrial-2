Rails.application.routes.draw do
  
  root "photos#index"


  

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  #resources :users, only: :show

  get ":username/liked" => "photos#liked", as: :liked_photos 
  get ":username/feed" => "photos#feed", as: :feed_photos
  #get ":username/followers" => "photos#liked", as: :followers 
  #get ":username/following" => "photos#liked", as: :liked_photos 

  get "/:username" => "users#show", as: :user


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
