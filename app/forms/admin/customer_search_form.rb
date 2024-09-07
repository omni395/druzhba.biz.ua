module Admin
  class CustomerSearchForm < BaseSearchForm

    set_condition :name_full_like,
                  :phone_full_like

    def perform(page = nil, limit: nil, csv: false)
      records = Customer.distinct
      records = apply_conditions(records, page, limit, csv)
      apply_sort(records, Customer.primary_key)
    end
  end
end