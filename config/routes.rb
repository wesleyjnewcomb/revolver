Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get '/albums', to: 'static_pages#index'
<<<<<<< HEAD
  get '/albums/new', to: 'static_pages#index'
=======

  namespace :api do
    namespace :v1 do
      resources :albums, only: [:index, :show, :create]
    end
  end
>>>>>>> 2d26c6792a90ea85cdb181bb620b4c21a4181d9f
end
