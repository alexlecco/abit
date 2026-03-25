Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "dashboard#index"

  resources :habits do
    resources :habit_logs, only: [ :create, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
