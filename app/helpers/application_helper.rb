# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def all_locales
    I18n.available_locales
  end

  def alternate_locale_link
    alternate_locale = I18n.locale == :uk ? :ru : :uk
    current_path = request.path
    current_params = request.query_parameters

    begin
      # Получаем текущий маршрут
      current_route = Rails.application.routes.recognize_path(current_path)
      
      if current_path == '/' || current_path == '/ru' || current_path == '/uk'
        # Если это корневой маршрут
        alternate_path = "/#{alternate_locale}"
      elsif current_route[:controller] && current_route[:action] == 'show'
        # Если это RESTful маршрут с параметром :id
        model_name = current_route[:controller].classify
        model_class = model_name.constantize
        
        if model_class.respond_to?(:friendly)
          # Находим текущий объект
          current_object = model_class.friendly.find(current_route[:id])
          
          # Генерируем альтернативный путь
          I18n.with_locale(alternate_locale) do
            alternate_slug = current_object.friendly_id
            alternate_path = url_for(controller: current_route[:controller],
                                     action: 'show',
                                     id: alternate_slug,
                                     only_path: true,
                                     locale: alternate_locale)
          end
        else
          # Если модель не использует friendly_id
          alternate_path = current_path.sub("/#{I18n.locale}/", "/#{alternate_locale}/")
        end
      else
        # Для других случаев
        alternate_path = current_path.sub("/#{I18n.locale}/", "/#{alternate_locale}/")
      end
    rescue => e
      # Если что-то пошло не так, просто заменим текущую локаль на альтернативную
      alternate_path = current_path == '/' ? "/#{alternate_locale}" : current_path.sub("/#{I18n.locale}/", "/#{alternate_locale}/")
    end

    # Добавляем текущие параметры запроса к альтернативному пути
    alternate_url = alternate_path.presence || "/"
    alternate_url += "?#{current_params.to_query}" if current_params.any?

    # Убеждаемся, что URL начинается с /
    alternate_url = "/#{alternate_url}" unless alternate_url.start_with?('/')

    # Убедимся, что URL не пустой и не дублирует текущий URL
    return nil if alternate_url.blank? || alternate_url == current_path

    if I18n.locale == :uk
      default_tag = tag.link(href: "https://druzhba.biz.ua#{request.path}", 
                            hreflang: "x-default", 
                            rel: "alternate")
    else
      default_tag = tag.link(href: "https://druzhba.biz.ua#{alternate_url}", 
                            hreflang: "x-default", 
                            rel: "alternate")
    end
    
    alternate_tag = tag.link(href: "https://druzhba.biz.ua#{alternate_url}", 
                            hreflang: alternate_locale, 
                            rel: "alternate")
    current_tag = tag.link(href: "https://druzhba.biz.ua#{request.path}", 
                          hreflang: I18n.locale,
                          rel: "alternate")

    safe_join([default_tag, alternate_tag, current_tag])
  end

  def canonical_link
    current_url = request.original_url
    uri = URI(current_url)
    canonical_url = "#{uri.scheme}://#{uri.host}#{request.path}"
    
    # Убираем trailing slash, если он есть (кроме корневого URL)
    canonical_url = canonical_url.chomp('/') unless canonical_url == "#{uri.scheme}://#{uri.host}/"
    
    tag.link(rel: "canonical", href: canonical_url)
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
