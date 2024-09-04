# frozen_string_literal: true

namespace :mandatory_expenses do
  desc 'Create mandatory expenses for the current month'
  task create_for_month: :environment do
    MandatoryExpense.current.each do |mandatory_expense|
      Expense.create!(
        title: mandatory_expense.expense_category.title,
        description: "Обязательный расход на #{Date.current.strftime('%B %Y')}",
        amount: mandatory_expense.amount,
        admin_user: AdminUser.find_by(role: :admin),
        expense_category: mandatory_expense.expense_category
      )
    end
  end
end
