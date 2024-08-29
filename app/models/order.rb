# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  after_create :new_money_flow_record
  after_update :update_money_flow_record
  after_destroy :destroy_money_flow_record

  scope :order_paid, -> { where(paid: inpaid) }

  private

  def new_money_flow_record
    return unless paid == 'inpaid'

    m = MoneyFlow.new
    m.order_id = id
    m.admin_user_id = admin_user_id
    m.title = 'title'
    m.description = 'description'
    m.total_amount = price
    m.money_flow_details.build(amount: price, money_flow_category_id: 1)
    m.save!
  end

  def update_money_flow_record
    if paid == 'inpaid'
      m = MoneyFlow.find_or_create_by(order_id: id)
      m.order_id = id
      m.admin_user_id = admin_user_id
      m.title = 'title'
      m.description = 'description'
      m.total_amount = price
      m.money_flow_details.update_all(amount: price) # не рабочая схема. обновляет все записи.
      m.money_flow_details.update_all(money_flow_category_id: 1)
      m.save!
    else
      MoneyFlow.find_by(order_id: id).destroy
    end
  end

  def destroy_money_flow_record
    MoneyFlow.find_by(order_id: id).destroy
  end
end
