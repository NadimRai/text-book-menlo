Rails.application.routes.draw do
  

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :listings do
    resources :orders, only: [:new, :create]
  end

  resources :listings do 
    resources :reviews
  end
  
  get 'pages/about'

  get 'pages/contact'

  get 'seller' , to: 'listings#seller'
  get 'search' , to: 'listings#search'
  get 'sales' , to: 'orders#sales'
  get 'purchases', to: 'orders#purchases'

  get 'login', to: 'devise/sessions#new', as: 'login'

  root 'listings#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
