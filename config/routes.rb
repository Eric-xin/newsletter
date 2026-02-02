Rails.application.routes.draw do
  root "pages#index"

  post "subscribe", to: "subscribers#create", as: :subscribe
  get "unsubscribe/:token", to: "subscribers#unsubscribe", as: :unsubscribe

  resources :announcements, only: [ :index, :show ]

  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard

    resources :newsletters do
      member do
        post :send_newsletter
      end
      collection do
        post :preview
      end
    end

    resources :subscribers, only: [ :index, :destroy ]

    get "settings", to: "settings#index", as: :settings
    patch "settings", to: "settings#update"
    post "settings/test_smtp", to: "settings#test_smtp", as: :test_smtp_settings
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
