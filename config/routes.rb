Rails.application.routes.draw do
  get 'post/index'

  get 'post/new'
  post 'post/create'
  devise_for :users


  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
