require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::LandingMessage.human_attribute_name(:id),
    Admin::LandingMessage.human_attribute_name(:name),
    Admin::LandingMessage.human_attribute_name(:phone),
    Admin::LandingMessage.human_attribute_name(:email),
    Admin::LandingMessage.human_attribute_name(:message),
    Admin::LandingMessage.human_attribute_name(:status),
    Admin::LandingMessage.human_attribute_name(:created_at),
    Admin::LandingMessage.human_attribute_name(:updated_at),
  ]
  # set body rows
  @landing_messages.each do |landing_message|
    csv << [
      landing_message.id,
      landing_message.name,
      landing_message.phone,
      landing_message.email,
      landing_message.message,
      landing_message.status_i18n,
      landing_message.created_at,
      landing_message.updated_at,
    ]
  end
end