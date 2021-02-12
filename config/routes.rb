Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  root to: 'topics#index'

  resources :topics

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end
end
