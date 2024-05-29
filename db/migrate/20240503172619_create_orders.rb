class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :status, :default => '0'
      t.integer :paid, :default => '0'
      t.integer :price

      t.timestamps
    end
  end
end
