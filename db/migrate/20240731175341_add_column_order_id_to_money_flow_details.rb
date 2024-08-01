class AddColumnOrderIdToMoneyFlowDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :money_flow_details, :order_id, :integer
  end
end
