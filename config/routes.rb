# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  
  end
  get '/# _=_', to: redirect('/') 
  resources :users, except: %i[create new]
  resources :friendships, except: %i[show] # , only: %i[create]
  resources :posts # , only: %i[index new create show destroy] do
  resources :likes, except: %i[index show] # , only: %i[create]
  resources :comments, except: %i[index show] # , only: %i[new create destroy] do
end
