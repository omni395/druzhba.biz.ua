require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
  ]
  # set body rows
  @customers.each do |customer|
    csv << [
    ]
  end
end