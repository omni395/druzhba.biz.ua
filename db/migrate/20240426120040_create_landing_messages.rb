# frozen_string_literal: true

class CreateLandingMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :landing_messages do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :message
      t.integer :status, default: '0'

      t.timestamps
    end
  end
end
