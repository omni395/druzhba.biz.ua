require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Customer.human_attribute_name(:id),
    Admin::Customer.human_attribute_name(:name),
    Admin::Customer.human_attribute_name(:phone),
    Admin::Customer.human_attribute_name(:email),
    Admin::Customer.human_attribute_name(:description),
    Admin::Customer.human_attribute_name(:created_at),
    Admin::Customer.human_attribute_name(:updated_at),
  ]
  # set body rows
  @customers.each do |customer|
    csv << [
      customer.id,
      customer.name,
      customer.phone,
      customer.email,
      customer.description,
      customer.created_at,
      customer.updated_at,
    ]
  end
end