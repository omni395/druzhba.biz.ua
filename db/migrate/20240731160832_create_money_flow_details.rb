# frozen_string_literal: true

class CreateExpenseDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_details do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :expense_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
