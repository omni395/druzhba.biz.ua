class MoneyFlow < ApplicationRecord
  belongs_to :admin_user
  has_many :money_flow_details
  
  validates :order_id, uniqueness: { allow_nil: true }
  validates :order_id, allow_blank: true, numericality: { allow_nil: true }
end
