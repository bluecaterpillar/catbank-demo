Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root 'home#index'

  post 'transfer', to: 'users#transfer', as: 'transfer'

  resources :users
  resources :sessions

  get 'sessions/new'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
