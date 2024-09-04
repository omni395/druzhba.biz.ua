# frozen_string_literal: true

module Admin
  class ExpenseCategorySearchForm < BaseSearchForm
    set_condition :id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = ExpenseCategory.distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :asc
      apply_sort(records, ExpenseCategory.primary_key)
    end
  end
end
