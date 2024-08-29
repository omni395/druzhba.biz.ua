# frozen_string_literal: true

class AddColumnRoleToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_users, :role, :integer, default: '1'
  end
end
