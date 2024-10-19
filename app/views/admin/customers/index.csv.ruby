# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  # set title row
  csv << []
  # set body rows
  @customers.each do |_customer|
    csv << []
  end
end
