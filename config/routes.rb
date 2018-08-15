Rails.application.routes.draw do

  get 'mypage/index'

  get 'mypage/edit'
  
  get 'mypage/modify'
  
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
  get 'post/show'
  post 'post/delete_join'
  post 'post/delpage'



  #user
  get 'passwords/edit' 


  # deivse gem
  devise_for :users, :skip => [:registrations]
  # For details on the DSL avaislable within this file, see http://guides.rubyonrails.org/routing.html
end
