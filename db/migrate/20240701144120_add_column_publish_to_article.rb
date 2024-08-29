# frozen_string_literal: true

class AddColumnPublishToArticle < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :published, :boolean
  end
end
