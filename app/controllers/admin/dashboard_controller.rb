# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    before_action { @page_title = 'Головна' }

    def index
      @start_date = params[:start_date] ? Date.parse(params[:start_date]) : 1.month.ago.to_date
      @end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.today

      @cash_flow = DoubleEntry::Line.where(account: 'external')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group('DATE(created_at)')
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 * -1 }

      @cash = DoubleEntry::Line.where(account: 'cash')
                                    .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                    .group('DATE(created_at)')
                                    .sum(:amount)
                                    .transform_values { |v| v.to_i / 100 }

      @expenses = DoubleEntry::Line.where(account: 'expense')
                                   .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                   .group('DATE(created_at)')
                                   .sum(:amount)
                                   .transform_values { |v| v.to_i / 100 }

      @accounts_receivable = DoubleEntry::Line.where(account: 'accounts_receivable')
                                              .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                              .group('DATE(created_at)')
                                              .sum(:amount)
                                              .transform_values { |v| v.to_i / 100 }

      @top_expense_categories = ExpenseCategory.joins(:expenses)
                                .where(expenses: { created_at: @start_date.beginning_of_day..@end_date.end_of_day })
                                .group(:title)
                                .sum('expenses.amount')
                                .transform_values { |v| v.to_i / 100 }
                                .sort_by { |_, v| -v }
                                .take(5)
      @salary_data = DoubleEntry::Line.where(account: 'salary')
                                .where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
                                .group(:scope)
                                .sum(:amount)
                                .transform_values { |v| v.to_i / 100 }
                          
      @users = AdminUser.where(id: @salary_data.keys)

    end
  end
end
