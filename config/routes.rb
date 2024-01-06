Rails.application.routes.draw do
  root 'posts#index', as: 'home'

  get 'about', to: 'pages#about', as: 'about'

  resources :posts do
    resources :comments
  end

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]
end
