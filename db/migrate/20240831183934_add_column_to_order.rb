class AddColumnToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :expense, null: true, foreign_key: true
  end
end
