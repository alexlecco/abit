Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "dashboard#index"

  resources :habits do
    resources :habit_logs, only: [ :create, :destroy ]
  end

  get "locale/:locale", to: "locales#update", as: :locale

  get "up" => "rails/health#show", as: :rails_health_check
end
