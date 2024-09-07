# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    before_action { @page_title = 'Головна' }
    
    def index
      @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
      @end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today

      @financial_data = get_financial_data
      @order_data = get_order_data
      @customer_data = get_customer_data
                          
      @users = AdminUser.where(id: @financial_data[:salary_data].keys)

    end

    private

    def get_financial_data
      {
        cash_flow: DoubleEntry::Line.where(account: 'customer')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group('DATE(created_at)')
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 * -1 },
        cash: DoubleEntry::Line.where(account: 'cash')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group('DATE(created_at)')
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 },
        expenses: DoubleEntry::Line.where(account: 'expense')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group('DATE(created_at)')
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 },
        accounts_receivable: DoubleEntry::Line.where(account: 'accounts_receivable')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group('DATE(created_at)')
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 },
        top_expense_categories: ExpenseCategory.joins(:expenses)
                                    .where(expenses: { created_at: @start_date.beginning_of_day..@end_date.end_of_day })
                                    .group(:title)
                                    .sum('expenses.amount')
                                    .transform_values { |v| v.to_i / 100 }
                                    .sort_by { |_, v| -v }
                                    .take(5),
        salary_data: DoubleEntry::Line.where(account: 'salary')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group(:scope)
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 }

                                  
      }
    end

    def get_order_data
      {
        total_orders: Order.where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                  .count,
        paid_orders: Order.where(paid: :inpaid)
                                  .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                  .count,
        unpaid_orders: Order.where(paid: :unpaid)
                                  .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                  .count,
        orders_by_status: Order.group(:status)
                                  .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                  .group('DATE(created_at)')
                                  .count,
        recent_orders: Order.order(created_at: :desc)
                                  .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                  .group('DATE(created_at)')
                                  .limit(10)

      }
    end

    def get_customer_data
      {
        total_customers: Customer.count,
        top_customers: Customer.joins(:orders).group('customers.id')
                                .order('SUM(orders.price) DESC')
                                .limit(5).select('customers.*, SUM(orders.price) as total_spent')
      }
    end
  end
end
