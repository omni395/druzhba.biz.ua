module Admin
  module OrderDecorator
    def status_color
      case status.to_s
      when 'new' then 'lime'
      when 'in_work' then 'pink'
      when 'done' then 'green'
      when 'rejected' then 'blue'
      else ''
      end
    end

    def paid_color
      case paid.to_s
      when 'unpaid' then 'red'
      when 'inpaid' then 'lime'
      else ''
      end
    end

    def created_at_display
      created_at ? I18n.l(created_at) : ''
    end

    def updated_at_display
      updated_at ? I18n.l(updated_at) : ''
    end

    def dead_date_display
      dead_date ? I18n.l(dead_date) : ''
    end

  end
end