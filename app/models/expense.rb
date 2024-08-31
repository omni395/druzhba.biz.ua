# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :admin_user
  belongs_to :expense_category
  belongs_to :order, optional: true

  validates :order_id, allow_blank: true, numericality: { allow_nil: true }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  
  after_commit :create_double_entry_transaction, on: :create
  after_commit :update_double_entry_transaction, on: :update, if: :saved_change_to_status?
  after_commit :destroy_double_entry_transaction, on: :destroy

  private

  def create_double_entry_transaction
    perform_double_entry_transaction(:expense_payment)
  end

  def update_double_entry_transaction
    return unless amount_changed? || expense_category_id_changed?
    
    refund_double_entry_transaction
    perform_double_entry_transaction(:expense_payment)
  end

  def destroy_double_entry_transaction
    perform_double_entry_transaction(:expense_refund, reverse: true)
  end

  def perform_double_entry_transaction(code, reverse: false)
    from_account, to_account = reverse ? 
      [DoubleEntry.account(:expense, scope: expense_category_id_was || expense_category_id), DoubleEntry.account(:cash)] :
      [DoubleEntry.account(:cash), DoubleEntry.account(:expense, scope: expense_category_id)]

    amount_cents = reverse ? (amount_was || amount) * 100 : amount * 100

    DoubleEntry.lock_accounts(DoubleEntry.account(:cash), DoubleEntry.account(:expense, scope: expense_category_id)) do
      DoubleEntry.transfer(
        Money.new(amount_cents, 'USD'),
        from: from_account,
        to: to_account,
        code: code
      )
    end
  end

end
