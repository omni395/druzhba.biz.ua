# frozen_string_literal: true

class AddColumnOwnerToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :admin_user, foreign_key: true
  end
end
