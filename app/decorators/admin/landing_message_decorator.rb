module Admin
  module LandingMessageDecorator
    def status_color
      case status.to_s
      when 'new' then 'lime'
      when 'in_work' then 'pink'
      when 'done' then 'green'
      when 'rejected' then 'blue'
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