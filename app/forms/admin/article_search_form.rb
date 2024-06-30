module Admin
  class ArticleSearchForm < BaseSearchForm

    set_condition :id_eq

    def perform(page = nil, limit: nil, csv: false)
      records = Article.includes(:service).distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :asc
      apply_sort(records, Article.primary_key)
    end
  end
end