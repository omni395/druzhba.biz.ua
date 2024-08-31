module Admin
  module ExpenseCategoryDecorator
    def flow_color
      case flow.to_s
      when 'income' then 'lime'
      when 'outcome' then 'red'
      else ''
      end
    end

    def created_at_display
      created_at ? I18n.l(created_at) : ''
    end

    def updated_at_display
      updated_at ? I18n.l(updated_at) : ''
    end

    def mandatory_display
      '<i class="bi bi-check-circle-fill h3 text-warning"></i>'.html_safe if mandatory?
    end

  end
end