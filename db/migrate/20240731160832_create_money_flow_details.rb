# frozen_string_literal: true

class CreateMoneyFlowDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :money_flow_details do |t|
      t.references :money_flow, null: false, foreign_key: true
      t.references :money_flow_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
