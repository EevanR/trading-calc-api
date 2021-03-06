Rails.application.routes.draw do
  get 'users/update'
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :trades, only: [:create, :index, :destroy]
      resources :setups, only: [:create, :index, :show, :destroy, :update]
      namespace :admin, defaults: { format: :json } do
        resources :users, only: [:update]
      end
    end
  end
end
