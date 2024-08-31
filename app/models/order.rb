# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user
  has_many :expenses

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  scope :order_paid, -> { where(paid: inpaid) }
  
  
  private
  

end
