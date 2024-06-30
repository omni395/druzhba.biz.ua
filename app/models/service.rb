class Service < ApplicationRecord
  has_many :order_details
  has_many :articles
  has_one_attached :image
end
