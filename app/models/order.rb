class Order < ApplicationRecord
  include FormattedField
  
  belongs_to :customer
  belongs_to :admin_user
  
  has_many :order_details, class_name: "order_details", foreign_key: "reference_id"

  
end
