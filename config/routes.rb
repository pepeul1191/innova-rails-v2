Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get 'sign-in', to: 'session#sign_in', as: :sign_in
  post 'sign-in', to: 'session#login', as: :login
  get 'reset-password', to: 'session#reset_password', as: :reset_password
  get 'sign-up', to: 'session#sign_up', as: :sign_up
  # Defines the root path route ("/")
  root "home#index"
end
