# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.string :description
      t.float :amount
      t.references :admin_user, null: false, foreign_key: true
      t.references :expense_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
