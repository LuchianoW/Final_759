Rails.application.routes.draw do
  resources :posts

  devise_for :users

  # 用 devise_scope 显式声明 root 跳转到登录页面
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:show]
get 'profile', to: 'users#show', defaults: { id: 'profile' }


end
