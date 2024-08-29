# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Service.human_attribute_name(:id),
    Admin::Service.human_attribute_name(:title),
    Admin::Service.human_attribute_name(:description),
    Admin::Service.human_attribute_name(:created_at),
    Admin::Service.human_attribute_name(:updated_at),
    Admin::Service.human_attribute_name(:price),
    Admin::Service.human_attribute_name(:svc),
    Admin::Service.human_attribute_name(:subtitle),
    Admin::Service.human_attribute_name(:slug)
  ]
  # set body rows
  @services.each do |service|
    csv << [
      service.id,
      service.title,
      service.description,
      service.created_at,
      service.updated_at,
      service.price,
      service.svc_i18n,
      service.subtitle,
      service.slug
    ]
  end
end
