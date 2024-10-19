# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :admin_user
  belongs_to :expense_category

  validates :amount, presence: true, numericality: { greater_than: 0 }

  after_commit :create_double_entry_transaction, on: :create
  after_commit :update_double_entry_transaction, on: :update # , if: :saved_change_to_amount? || :saved_change_to_expense_category_id?
  after_commit :destroy_double_entry_transaction, on: :destroy

  private

  def create_double_entry_transaction
    perform_double_entry_transaction(:expense_payment)
  end

  def update_double_entry_transaction
    destroy_double_entry_transaction
    perform_double_entry_transaction(:expense_payment)
  end

  def destroy_double_entry_transaction
    perform_double_entry_transaction(:expense_refund, reverse: true)
  end

  def perform_double_entry_transaction(code, reverse: false)
    from_account, to_account = if reverse
                                 [DoubleEntry.account(:expense, scope: expense_category_id_was || expense_category_id),
                                  DoubleEntry.account(:cash)]
                               else
                                 [DoubleEntry.account(:cash),
                                  DoubleEntry.account(:expense, scope: expense_category_id)]
                               end

    amount = reverse ? (amount_was || self.amount) * 100 : self.amount * 100

    DoubleEntry.lock_accounts(DoubleEntry.account(:cash), DoubleEntry.account(:expense, scope: expense_category_id)) do
      DoubleEntry.transfer(
        Money.new(amount),
        from: from_account,
        to: to_account,
        code:
      )
    end
  end
end
