require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Expense.human_attribute_name(:id),
    Admin::Expense.human_attribute_name(:title),
    Admin::Expense.human_attribute_name(:description),
    Admin::Expense.human_attribute_name(:amount),
    Admin::Expense.human_attribute_name(:order_id),
    Admin::Expense.human_attribute_name(:created_at),
    Admin::Expense.human_attribute_name(:updated_at),
    Admin::Expense.human_attribute_name(:admin_user_id),
  ]
  # set body rows
  @expenses.each do |expense|
    csv << [
      expense.id,
      expense.title,
      expense.description,
      expense.amount,
      expense.order_id,
      expense.created_at,
      expense.updated_at,
      expense.admin_user_id,
    ]
  end
end