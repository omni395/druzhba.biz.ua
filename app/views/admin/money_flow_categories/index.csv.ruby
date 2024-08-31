# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::ExpenseCategory.human_attribute_name(:id),
    Admin::ExpenseCategory.human_attribute_name(:title),
    Admin::ExpenseCategory.human_attribute_name(:description),
    Admin::ExpenseCategory.human_attribute_name(:flow),
    Admin::ExpenseCategory.human_attribute_name(:created_at),
    Admin::ExpenseCategory.human_attribute_name(:updated_at)
  ]
  # set body rows
  @expense_categories.each do |expense_category|
    csv << [
      expense_category.id,
      expense_category.title,
      expense_category.description,
      expense_category.flow_i18n,
      expense_category.created_at,
      expense_category.updated_at
    ]
  end
end
