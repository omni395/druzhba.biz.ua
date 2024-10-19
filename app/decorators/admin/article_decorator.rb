# frozen_string_literal: true

module Admin
  module ArticleDecorator
    def created_at_display
      created_at ? I18n.l(created_at) : ''
    end

    def updated_at_display
      updated_at ? I18n.l(updated_at) : ''
    end

    def published_display
      if published?
        '<i class="bi bi-check-circle-fill h3 text-warning"></i>'.html_safe
      else
        '<i class="bi bi-check-circle-fill h3 text-muted"></i>'.html_safe
      end
    end
  end
end
