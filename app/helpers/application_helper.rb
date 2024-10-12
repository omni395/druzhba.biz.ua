# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def all_locales
    I18n.available_locales
  end

  def alternate_locale_link
    alternate_locale = I18n.locale == :uk ? :ru : :uk
    alternate_url = url_for(request.params.merge(locale: alternate_locale))
    tag.link(href: "https://druzhba.biz.ua#{alternate_url}", 
             hreflang: alternate_locale, 
             rel: "alternate")
  end

  def canonical_link(options = {})
    default_options = {
      domain: 'https://druzhba.biz.ua',
      include_params: []
    }
    options = default_options.merge(options)

    canonical_params = request.params.slice(*options[:include_params])
    canonical_url = url_for(canonical_params.merge(only_path: true))
    
    tag.link(rel: "canonical", href: "#{options[:domain]}#{canonical_url}")
  end

  def page_title(custom_title = nil, options = {})
  default_options = {
    truncate_length: 70,
    default_titles: {
      uk: "Швейна майстерня ☞ ДРУЖБА ☜",
      ru: "Швейное ателье ☞ ДРУЖБА ☜"
    }
  }
  options = default_options.merge(options)

  title = if custom_title.present?
            custom_title.truncate(options[:truncate_length])
          else
            options[:default_titles][I18n.locale] || options[:default_titles][:uk]
          end

  content_tag(:title, title)
end
end
