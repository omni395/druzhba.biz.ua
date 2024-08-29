# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::MoneyFlow.human_attribute_name(:id),
    Admin::MoneyFlow.human_attribute_name(:title),
    Admin::MoneyFlow.human_attribute_name(:description),
    Admin::MoneyFlow.human_attribute_name(:total_amount),
    Admin::MoneyFlow.human_attribute_name(:order_id),
    Admin::MoneyFlow.human_attribute_name(:created_at),
    Admin::MoneyFlow.human_attribute_name(:updated_at),
    Admin::MoneyFlow.human_attribute_name(:admin_user_id)
  ]
  # set body rows
  @money_flows.each do |money_flow|
    csv << [
      money_flow.id,
      money_flow.title,
      money_flow.description,
      money_flow.total_amount,
      money_flow.order_id,
      money_flow.created_at,
      money_flow.updated_at,
      money_flow.admin_user_id
    ]
  end
end
