require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Order.human_attribute_name(:id),
    Admin::Order.human_attribute_name(:status),
    Admin::Order.human_attribute_name(:paid),
    Admin::Order.human_attribute_name(:price),
    Admin::Order.human_attribute_name(:created_at),
    Admin::Order.human_attribute_name(:updated_at),
    Admin::Order.human_attribute_name(:daadline),
    Admin::Order.human_attribute_name(:deadline),
    Admin::Order.human_attribute_name(:dead_date),
    Admin::Order.human_attribute_name(:dead_time),
    Admin::Order.human_attribute_name(:admin_user_id),
    Admin::Order.human_attribute_name(:customer_id),
  ]
  # set body rows
  @orders.each do |order|
    csv << [
      order.id,
      order.status_i18n,
      order.paid_i18n,
      order.price,
      order.created_at,
      order.updated_at,
      order.daadline,
      order.deadline,
      order.dead_date,
      order.dead_time,
      order.admin_user_id,
      order.customer_id,
    ]
  end
end