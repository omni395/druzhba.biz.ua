# frozen_string_literal: true

module Admin
  class OrderSearchForm < BaseSearchForm
    set_condition :customer_id_eq,
                  :admin_user_id_eq,
                  :status_any,
                  :paid_any

    def perform(page = nil, limit: nil, csv: false)
      records = Order.includes(:customer, :admin_user).distinct
      records = apply_conditions(records, page, limit, csv)
      @sort_field ||= :id
      @sort_kind  ||= :desc
      apply_sort(records, Order.primary_key)
    end

    def customer_name
      Customer.find(customer_id_eq)&.name if customer_id_eq.present?
    end

    def admin_user_name
      AdminUser.find(admin_user_id_eq)&.name if admin_user_id_eq.present?
    end
  end
end
