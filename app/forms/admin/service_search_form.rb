# frozen_string_literal: true

module Admin
  class ServiceSearchForm < BaseSearchForm
    set_condition :title_full_like,
                  :svc_any

    def perform(page = nil, limit: nil, csv: false)
      records = Service.distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :asc
      apply_sort(records, Service.primary_key)
    end
  end
end
