Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users
      devise_scope :user do
        post '/authentication_tokens/create', to: "authentication_tokens#create"
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
