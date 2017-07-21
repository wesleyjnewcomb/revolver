Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get '/albums', to: 'static_pages#index'
  get '/albums/new', to: 'static_pages#index'

  namespace :api do
    namespace :v1 do
      resources :albums, only: [:index, :show, :create] do
        resources :reviews, only: [:index]
      end
      resources :reviews, only: [:index, :show, :create]
    end
  end
end
