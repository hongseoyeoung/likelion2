Rails.application.routes.draw do
  get 'notice/index'

  get 'notice/create'

  post 'notice/new'

  get 'notice/edit'

  get 'notice/delete'

  get 'post/index'
  get 'post/notice'
  get 'post/new'
  post 'post/create'
  get 'post/customer'
  get 'post/mypage'
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
