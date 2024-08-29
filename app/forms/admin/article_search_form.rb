# frozen_string_literal: true

module Admin
  class ArticleSearchForm < BaseSearchForm
    set_condition :service_id_eq,
                  :published_eq

    def perform(page = nil, limit: nil, csv: false)
      records = Article.includes(:service).distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :asc
      apply_sort(records, Article.primary_key)
    end

    def service_title
      Service.find(service_id_eq)&.title if service_id_eq.present?
    end
  end
end
