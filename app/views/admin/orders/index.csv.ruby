require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
  ]
  # set body rows
  @orders.each do |order|
    csv << [
    ]
  end
end