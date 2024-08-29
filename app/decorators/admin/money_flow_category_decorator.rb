# frozen_string_literal: true

module Admin
  module MoneyFlowCategoryDecorator
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
  end
end
