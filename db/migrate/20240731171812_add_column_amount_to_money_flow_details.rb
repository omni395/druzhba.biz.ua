# frozen_string_literal: true

class AddColumnAmountToExpenseDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_details, :amount, :float
  end
end
