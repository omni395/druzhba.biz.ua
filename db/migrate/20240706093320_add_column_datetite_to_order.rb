# frozen_string_literal: true

class AddColumnDatetiteToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :dead_date, :date
    add_column :orders, :dead_time, :time
  end
end
