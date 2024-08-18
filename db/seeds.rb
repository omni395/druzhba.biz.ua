AdminUser.create(email: 'admin@example.com', password: '12345678', role: 0)

100.times do
  Article.create(
    title: "Faker::Book.title",
    description: "Faker::Book.title",
    service_id: 1,
    body: "Faker::Lorem.paragraph",
    published: true
  )
end

15.times do
  LandingMessage.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, status: Faker::Number.between(from: 0, to: 3), message: Faker::Lorem.paragraph)
end

15.times do
  Customer.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, description: Faker::Lorem.paragraph)
end

15.times do
  Service.create(title: Faker::Commerce.product_name.upcase_first, subtitle: Faker::Commerce.product_name.upcase_first, description: Faker::Lorem.paragraph, body: Faker::Lorem.paragraph)
end

15.times do
  Order.create(customer_id: Faker::Number.between(from: 0, to: 14), status: Faker::Number.between(from: 0, to: 3), price: Faker::Commerce.price(range: 0..200), paid: Faker::Number.between(from: 0, to: 1), description: Faker::Lorem.paragraph)
end

15.times do
  OrderDetail.create(order_id: Faker::Number.between(from: 15, to: 29), service_id: Faker::Number.between(from: 0, to: 14))
end