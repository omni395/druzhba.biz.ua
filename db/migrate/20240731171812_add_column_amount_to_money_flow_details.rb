class AddColumnAmountToMoneyFlowDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :money_flow_details, :amount, :float
  end
end
