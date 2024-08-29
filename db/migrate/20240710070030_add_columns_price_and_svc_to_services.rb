# frozen_string_literal: true

class AddColumnsPriceAndSvcToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :price, :integer
    add_column :services, :svc, :integer
  end
end
