# frozen_string_literal: true

module Admin
  module AdminUserDecorator
    def reset_password_sent_at_display
      reset_password_sent_at ? I18n.l(reset_password_sent_at) : ''
    end

    def remember_created_at_display
      remember_created_at ? I18n.l(remember_created_at) : ''
    end

    def created_at_display
      created_at ? I18n.l(created_at) : ''
    end

    def updated_at_display
      updated_at ? I18n.l(updated_at) : ''
    end
  end
end
