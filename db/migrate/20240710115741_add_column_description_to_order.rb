class AddColumnDescriptionToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :description, :string
  end
end
