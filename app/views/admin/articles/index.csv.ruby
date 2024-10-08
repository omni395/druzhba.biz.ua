# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Article.human_attribute_name(:id),
    Admin::Article.human_attribute_name(:title),
    Admin::Article.human_attribute_name(:description),
    Admin::Article.human_attribute_name(:body),
    Admin::Article.human_attribute_name(:created_at),
    Admin::Article.human_attribute_name(:updated_at),
    Admin::Article.human_attribute_name(:published),
    Admin::Article.human_attribute_name(:service_id),
    Admin::Article.human_attribute_name(:slug)
  ]
  # set body rows
  @articles.each do |article|
    csv << [
      article.id,
      article.title,
      article.description,
      article.body,
      article.created_at,
      article.updated_at,
      article.published,
      article.service_id,
      article.slug
    ]
  end
end
