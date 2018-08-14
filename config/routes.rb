Rails.application.routes.draw do

  root 'home#index'


  # notice
  get 'notice/index'
  post 'notice/new'
  get 'notice/create'
  get 'notice/edit'
  get 'notice/delete'

  # post
  get 'post/join'
  get 'post/index'
  get 'post/notice'
  get 'post/new'
  post 'post/create'
  get 'post/customer'
  get 'post/mypage'






  # deivse gem
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
