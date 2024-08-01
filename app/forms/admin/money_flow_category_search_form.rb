module Admin
  class MoneyFlowCategorySearchForm < BaseSearchForm

    set_condition :title_full_like,
                  :flow_any

    def perform(page = nil, limit: nil, csv: false)
      records = MoneyFlowCategory.distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :asc
      apply_sort(records, MoneyFlowCategory.primary_key)
    end
  end
end