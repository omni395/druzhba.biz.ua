# frozen_string_literal: true

class AddColumnNameToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_users, :name, :string
  end
end
