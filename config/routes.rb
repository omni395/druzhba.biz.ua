Rails.application.routes.draw do
  root to: 'landing#index'
  
  # Admin routes with gem infold  
  draw(:admin)

  # Отправка сообщения
  resources :landing_messages, only: [:new, :create]
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
