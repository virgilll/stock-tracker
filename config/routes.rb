Rails.application.routes.draw do
  resources :user_stocks, only: %i[create destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'user_friends', to: 'users#user_friends'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: %i[create destroy]
end
