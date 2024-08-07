class MoneyFlow < ApplicationRecord
  belongs_to :admin_user
  has_many :money_flow_details, dependent: :destroy
  
  validates :order_id, allow_blank: true, numericality: { allow_nil: true }

  
  after_save :total_amount_sum

  private

  def total_amount_sum
    total_amount = self.money_flow_details.sum(:amount)
    self.update_column(:total_amount, total_amount)
  end

end
