class Order < ApplicationRecord
  include FormattedField
  
  belongs_to :customer
  belongs_to :admin_user
  
  has_many :order_details, class_name: "order_details", foreign_key: "reference_id"

  after_create :money_flow_record
  after_update :money_flow_record
  after_destroy :destroy_flow_record

  private

  def money_flow_record
    if self.paid == 1
      m = MoneyFlow.new
      m.order_id = self.id
      m.admin_user_id = self.admin_user_id
      m.title = "title"
      m.description = "description"
      m.total_amount = self.price
      m.money_flow_details.build(amount: self.price, money_flow_category_id: 1)
      m.save!
    end
  end

  def destroy_flow_record
    MoneyFlow.find_by(order_id: self.id).destroy
  end

end
