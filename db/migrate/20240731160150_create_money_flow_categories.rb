class CreateMoneyFlowCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :money_flow_categories do |t|
      t.string :title
      t.string :description
      t.integer :flow

      t.timestamps
    end
  end
end
