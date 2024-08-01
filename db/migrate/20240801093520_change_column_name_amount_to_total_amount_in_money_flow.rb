class ChangeColumnNameAmountToTotalAmountInMoneyFlow < ActiveRecord::Migration[7.1]
  def change
    # rename_column :table_name, :old_column, :new_column
    rename_column :money_flows, :amount, :total_amount
  end
end
