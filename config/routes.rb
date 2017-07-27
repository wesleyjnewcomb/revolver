Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get '/albums', to: 'static_pages#index'
  get '/albums/new', to: 'static_pages#index'
  get '/albums/:id', to: 'static_pages#index'
  get '/albums/:id/edit', to: 'static_pages#index'
  get '/albums/:id/reviews/new', to: 'static_pages#index'

  namespace :api do
    namespace :v1 do
      resources :albums, only: [:index, :show, :create, :update, :destroy] do
        resources :reviews, only: [:index]
      end
      resources :reviews, only: [:index, :show, :create, :destroy]
      resources :votes, only: [:create]
    end
  end
end
