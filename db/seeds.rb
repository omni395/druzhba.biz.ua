# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.create(email: 'admin@example.com', password: '12345678')

15.times do
  LandingMessage.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, status: Faker::Number.between(from: 0, to: 3), message: Faker::Lorem.paragraph)
end

15.times do
  Customer.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, description: Faker::Lorem.paragraph)
end

15.times do
  Service.create(title: Faker::Commerce.product_name.upcase_first, description: Faker::Lorem.paragraph)
end

15.times do
  Order.create(customer_id: Faker::Number.between(from: 0, to: 14), status: Faker::Number.between(from: 0, to: 3), price: Faker::Commerce.price(range: 0..200), paid: Faker::Number.between(from: 0, to: 1))
end

15.times do
  OrderDetail.create(order_id: Faker::Number.between(from: 15, to: 29), service_id: Faker::Number.between(from: 0, to: 14))
end