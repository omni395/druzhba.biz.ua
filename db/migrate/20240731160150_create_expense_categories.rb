# frozen_string_literal: true

class CreateExpenseCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_categories do |t|
      t.string :title
      t.string :description
      t.integer :flow

      t.timestamps
    end
  end
end
