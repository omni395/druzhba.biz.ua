# frozen_string_literal: true

module Admin
  class LandingMessageSearchForm < BaseSearchForm
    set_condition :name_full_like,
                  :email_full_like,
                  :status_any

    def perform(page = nil, limit: nil, csv: false)
      records = LandingMessage.distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :desc
      apply_sort(records, LandingMessage.primary_key)
    end
  end
end
