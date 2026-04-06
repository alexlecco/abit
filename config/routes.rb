Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "dashboard#index"

  resources :habits do
    resources :habit_logs,           only: [ :create, :destroy ]
    resource  :path_selection,       only: [ :create ], controller: "path_selections"
    resources :activities,           only: [ :create, :update, :destroy ]
    resources :activity_completions, only: [ :create, :destroy ]
    resources :learning_resources,   only: [ :create, :update, :destroy ]
    resource  :goal,                 only: [ :create, :update ], controller: "goals"
    resources :weekly_milestones,    only: [ :create, :update ]
    resources :daily_checkins,       only: [ :create, :destroy ]
  end

  get "locale/:locale", to: "locales#update", as: :locale

  get "up" => "rails/health#show", as: :rails_health_check
end
