require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Service.human_attribute_name(:id),
    Admin::Service.human_attribute_name(:title),
    Admin::Service.human_attribute_name(:description),
    Admin::Service.human_attribute_name(:created_at),
    Admin::Service.human_attribute_name(:updated_at),
  ]
  # set body rows
  @services.each do |service|
    csv << [
      service.id,
      service.title,
      service.description,
      service.created_at,
      service.updated_at,
    ]
  end
end