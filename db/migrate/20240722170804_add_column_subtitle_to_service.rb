class AddColumnSubtitleToService < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :subtitle, :string
  end
end
