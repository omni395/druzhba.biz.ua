# frozen_string_literal: true

Rails.application.routes.draw do
  # Admin routes with gem infold
  draw(:admin)

  root to: redirect("/#{I18n.default_locale}", status: 301), as: :redirected_root

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'landing#index'

    get 'prices', to: 'landing#prices'
    get 'about', to: 'landing#about'
    get 'contacts', to: 'landing#contacts'
    get 'faq', to: 'landing#faq'
    get 'policy', to: 'landing#policy'

    # Cookies and Policy
    get 'cookies', to: 'cookies#index'

    # Отправка сообщения
    resources :landing_messages, only: %i[new create]
    # Послуги
    resources :services, only: %i[index show]
    # Статті до послуг
    resources :articles, only: %i[index show]

    # Sitemap
    get 'sitemap', to: 'landing#sitemap'
    # GoogoeADS
    # get "ads", to: "landing#ads", defaults: { format: 'text' }

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get 'up' => 'rails/health#show', as: :rails_health_check
  end
end
