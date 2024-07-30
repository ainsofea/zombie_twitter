Rails.application.routes.draw do
  resources :users, only: [:new, :create, :create] do
    resources :tweets, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end

  # Signup and login routes
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # User
  get 'profile', to: 'profiles#show', as: 'profile'

  # Tweets routes 
  resources :tweets, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  get 'tweets/:id/edit', to: 'tweets#edit'

  # Defines the root path route ("/")
  root "pages#landingpage"
end
