Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'games#index'
  resources :games, only: %i[new create show update] do
    patch 'forfeit', on: :member
    resources :messages, only: [:update, :show]
  end
  resources :pieces, only: [:update]
  mount ActionCable.server => '/cable'
end
