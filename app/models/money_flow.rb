class MoneyFlow < ApplicationRecord
  belongs_to :admin_user
  has_many :money_flow_detail
end
