module Admin
  class AdminUserSearchForm < BaseSearchForm

    set_condition :email_eq

    def perform(page = nil, limit: nil, csv: false)
      records = AdminUser.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, AdminUser.primary_key)
    end
  end
end