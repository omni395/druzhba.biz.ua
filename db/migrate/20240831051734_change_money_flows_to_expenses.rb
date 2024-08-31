class ChangeExpensesToExpenses < ActiveRecord::Migration[7.1]
  def change
    rename_table :expenses, :expenses
  end
end
