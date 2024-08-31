# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user
  has_many :expenses

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  scope :order_paid, -> { where(paid: inpaid) }
  
  after_create :process_payment
  
  private
  
  def process_payment
    total_amount = Money.new(price * 100, 'USD')
    
    DoubleEntry.transfer(
      total_amount,
      from: DoubleEntry.account(:customer, scope: customer),
      to: DoubleEntry.account(:cash),
      code: :order_payment
    )
    
    if admin_user.manager?
      manager_amount = total_amount * 0.5
      DoubleEntry.transfer(
        manager_amount,
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:salary, scope: admin_user),
        code: :manager_salary
      )
      
      Expense.create(
        title: "Зарплата менеджера",
        description: "50% от заказа ##{id}",
        amount: manager_amount.to_f,
        admin_user: admin_user,
        expense_category: ExpenseCategory.find_by(title: 'Зарплата'),
        order: self
      )
    end
  end
end
