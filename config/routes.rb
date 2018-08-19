Rails.application.routes.draw do

  get 'sendmail/index'

  get 'mypage/index'

  get 'mypage/edit'
  
  get 'mypage/modify'
  
  root 'home#index'

  get 'sendmail/index'
  # notice
  get 'notice/index'
  post 'notice/new'
  get 'notice/create'
  get 'notice/:id/edit' => 'notice#edit'
  post 'notice/delete/:id' => 'notice#delete'
  get 'notice/show/:id' => 'notice#show'
  get 'notice/:id/notices_update' => 'notice#update'

  # post
  get 'post/join'
  get 'post/index'
  get 'post/notice'
  get 'post/new'
  post 'post/create'
  get 'post/customer'
  get 'post/mypage'
  get 'post/show'
  get 'post/edit/:id' => 'post#edit', :as => 'post_edit'
  post 'post/delete_join'
  post 'post/delpage'
  post 'post/update'


  #comment
  post 'comment/create'
  post 'comment/destroy'

  #user
  get 'passwords/edit' 


  # deivse gem
  devise_for :users
  # For details on the DSL avaislable within this file, see http://guides.rubyonrails.org/routing.html
end
