Rails.application.routes.draw do
  root 'posts#index', as: 'home'

  get 'about', to: 'pages#about', as: 'about'

  resources :posts do
    resources :comments
  end

  resource :session, only: %i[new create destroy]

  resources :users, except: %i[index]
end
