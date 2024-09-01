class DeleteColumnFlowFromExpenseCategory < ActiveRecord::Migration[7.1]
  def change
    remove_column :expense_categories, :flow
  end
end
