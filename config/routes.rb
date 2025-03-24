Rails.application.routes.draw do
  get "reports/water_usage"
  get "reports/maintenance_history"
  # --------------------------------------------
  # Authentication & Authorization Routes (Devise)
  # --------------------------------------------
  devise_for :users

  # --------------------------------------------
  # Core Application Routes
  # --------------------------------------------
  # Root route (redirects based on user role)
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end


  # Unauthenticated users go to login (wrapped in devise_scope)
  devise_scope :user do
    root to: "devise/sessions#new"
    # Add other Devise-constrained routes here if needed
    get "/users/sign_out" => "devise/sessions#destroy" # Explicit logout path
  end


  # Dashboard
  get "dashboard", to: "dashboard#index"

  # Pipeline Management (CRUD operations)
  resources :pipelines, except: [ :destroy ] do
    collection do
      get :map_overview # Custom route for GIS map view
    end
  end

  # --------------------------------------------
  # Real-Time Monitoring & Alerts
  # --------------------------------------------
  namespace :monitoring do
    get "alerts", to: "alerts#index" # Real-time pressure/leak alerts
  end

  # --------------------------------------------
  # Reports
  # --------------------------------------------
  get "reports/water_usage", to: "reports#water_usage"
  get "reports/maintenance", to: "reports#maintenance_history"

  # --------------------------------------------
  # Admin Section (Role-restricted)
  # --------------------------------------------
  namespace :admin do
    resources :users # User management
    resources :system_settings, only: [ :index, :update ]
  end

  # --------------------------------------------
  # API Endpoints (Future mobile app integration)
  # --------------------------------------------
  namespace :api do
    namespace :v1 do
      resources :pipelines, only: [ :index, :show ]
      post "sensor_data", to: "sensor_data#create"
    end
  end

  # --------------------------------------------
  # Action Cable (WebSocket) for Real-Time Alerts
  # --------------------------------------------
  mount ActionCable.server => "/cable"

  # --------------------------------------------
  # Sidekiq Web Interface (Monitor background jobs)
  # --------------------------------------------
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
