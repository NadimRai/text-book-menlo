Rails.application.routes.draw do
  
  devise_for :users

  resources :listings do
    resources :orders, only: [:new, :create]
  end
  
  get 'pages/about'

  get 'pages/contact'

  get 'seller' , to: 'listings#seller'
  get 'sales' , to: 'orders#sales'
  get 'purchases', to: 'orders#purchases'

  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
