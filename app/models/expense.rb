# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :admin_user
  belongs_to :expense_category
  belongs_to :order, optional: true

  validates :order_id, allow_blank: true, numericality: { allow_nil: true }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  
  after_create :create_double_entry_transaction
  
  private
  
  def create_double_entry_transaction
    DoubleEntry.transfer(
      Money.new(amount * 100, 'USD'),
      from: DoubleEntry.account(:cash),
      to: DoubleEntry.account(:expense, scope: expense_category),
      code: :expense
    )
  end

end
