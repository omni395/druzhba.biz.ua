Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'landing#index'
    
    get "prices", to: "landing#prices"
    get "about", to: "landing#about"
    get "contacts", to: "landing#contacts"
    get "faq", to: "landing#faq"

    # Admin routes with gem infold  
    draw(:admin)

    # Отправка сообщения
    resources :landing_messages, only: [:new, :create]
    # Послуги
    resources :services
    # Статті до послуг
    resources :articles, only: [:index, :show]

    # Sitemap
    get 'sitemap' => 'landing#sitemap'
    
    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check
  end
end
