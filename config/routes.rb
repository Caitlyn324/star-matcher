Rails.application.routes.draw do
  devise_for :actors
  root to: 'auditions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :auditions do
    resources :participants, only: [:create, :destroy]
  end
  resources :actors

  namespace :api do
    namespace :v1 do
      resources :auditions, only: [:index]
    end
  end

end
