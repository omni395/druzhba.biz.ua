# frozen_string_literal: true

module Admin
  module ServiceDecorator
    def svc_color
      case svc.to_s
      when 'repair' then 'lime'
      when 'sewing' then 'green'
      else ''
      end
    end

    def created_at_display
      created_at ? I18n.l(created_at) : ''
    end

    def updated_at_display
      updated_at ? I18n.l(updated_at) : ''
    end
  end
end
