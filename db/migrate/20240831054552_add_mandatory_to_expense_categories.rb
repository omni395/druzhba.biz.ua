class AddMandatoryToExpenseCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_categories, :mandatory, :boolean, default: false
  end
end
