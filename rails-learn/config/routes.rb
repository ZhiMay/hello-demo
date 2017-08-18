Rails.application.routes.draw do
  # get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  resources :users #为演示应用中的 Users 资源提供了符合 REST 架构的所有动作,以及用来获取相应 URL 的具名路由
end
