class DropTableExpenseDetails < ActiveRecord::Migration[7.1]
  def change
    drop_table :expense_details
  end
end
