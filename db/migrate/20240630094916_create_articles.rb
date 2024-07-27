class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.references :service, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
