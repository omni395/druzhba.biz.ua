class CreateMandatoryExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :mandatory_expenses do |t|
      t.references :expense_category, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :effective_from, null: false
      t.date :effective_to

      t.timestamps
    end
  end
end
