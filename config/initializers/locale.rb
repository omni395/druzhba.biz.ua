I18n.config.available_locales = [:uk, :en]
I18n.default_locale = :uk
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]