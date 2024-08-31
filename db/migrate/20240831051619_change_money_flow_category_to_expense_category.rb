class ChangeExpenseCategoryToExpenseCategory < ActiveRecord::Migration[7.1]
  def change
    rename_table :expense_categories, :expense_categories
  end
end
