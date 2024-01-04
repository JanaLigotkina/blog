Rails.application.routes.draw do
  root 'posts#index', as: 'home'

  get 'about', to: 'pages#about', as: 'about'

  resources :posts
end
