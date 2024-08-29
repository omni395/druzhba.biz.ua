# frozen_string_literal: true

module Admin
  class AdminUserSearchForm < BaseSearchForm
    set_condition :email_eq,
                  :name_full_like

    def perform(page = nil, limit: nil, csv: false)
      records = AdminUser.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, AdminUser.primary_key)
    end
  end
end
