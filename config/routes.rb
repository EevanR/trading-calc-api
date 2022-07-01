Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :trades, only: [:create, :index, :destroy]
      resources :setups, only: [:create, :index, :show, :destroy, :update]
      resources :tweets, only: [:create, :index, :show, :destroy, :update]
      resources :excels, only: [:create, :index, :destroy, :update]
      resources :subscriptions, only: [:create]
      resources :webhooks, only: [:create]
      resources :stripe_portals, only: [:create]
      namespace :admin, defaults: { format: :json } do
        resources :users, only: [:update, :show]
        resources :excels, only: [:index, :create, :update]
      end
    end
  end
end