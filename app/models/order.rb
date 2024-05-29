class Order < ApplicationRecord
  include FormattedField
  
  belongs_to :customer
  has_many :order_details, class_name: "order_details", foreign_key: "reference_id"
end
