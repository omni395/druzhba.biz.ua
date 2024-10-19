# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  # set title row
  csv << []
  # set body rows
  @orders.each do |_order|
    csv << []
  end
end
