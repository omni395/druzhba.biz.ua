module Admin
  class MoneyFlowSearchForm < BaseSearchForm

    set_condition :admin_user_id_eq,
                  :money_flow_category_eq

    def perform(page = nil, limit: nil, csv: false)
      records = MoneyFlow.includes(:admin_user).distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :desc
      apply_sort(records, MoneyFlow.primary_key)
    end

    def admin_user_name
      AdminUser.find(admin_user_id_eq)&.name if admin_user_id_eq.present?
    end
  end
end