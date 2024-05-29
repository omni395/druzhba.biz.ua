require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::AdminUser.human_attribute_name(:id),
    Admin::AdminUser.human_attribute_name(:encrypted_password),
    Admin::AdminUser.human_attribute_name(:reset_password_sent_at),
    Admin::AdminUser.human_attribute_name(:remember_created_at),
    Admin::AdminUser.human_attribute_name(:created_at),
    Admin::AdminUser.human_attribute_name(:updated_at),
    Admin::AdminUser.human_attribute_name(:email),
    Admin::AdminUser.human_attribute_name(:reset_password_token),
  ]
  # set body rows
  @admin_users.each do |admin_user|
    csv << [
      admin_user.id,
      admin_user.encrypted_password,
      admin_user.reset_password_sent_at,
      admin_user.remember_created_at,
      admin_user.created_at,
      admin_user.updated_at,
      admin_user.email,
      admin_user.reset_password_token,
    ]
  end
end