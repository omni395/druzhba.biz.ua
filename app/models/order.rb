# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  scope :order_paid, -> { where(paid: paid) }

  after_commit :create_double_entry_transaction, on: :create
  after_commit :update_double_entry_transaction, on: :update #, if: :saved_change_to_paid?
  after_commit :remove_double_entry_transaction, on: :destroy

  private

  def create_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:external),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      if paid == 'inpaid'
        perform_order_paid_transaction(:order_payment)
        if admin_user.role == 'manager'
          perform_manager_salary_transaction(:salary_payment)
        end
      else
        perform_order_unpaid_transaction(:order_unpaid)
      end
    end
  end

  def update_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:external),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      #remove_double_entry_transaction
      if paid == 'inpaid'
        perform_update_order_transaction(:order_to_paid)
        if admin_user.role_was == 'admin'
          perform_manager_salary_transaction(:salary_payment, reverse: true)
        end
      else
        perform_update_order_transaction(:order_to_unpaid, reverse: true)
      end
    end
  end
 
  def remove_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:external),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      if paid == 'inpaid'
        perform_order_paid_transaction(:order_refund, reverse: true)
        if admin_user.role == 'manager'
          perform_manager_salary_transaction(:salary_refund, reverse: true)
        end
      else
        perform_order_unpaid_transaction(:order_remove, reverse: true)
      end
    end
  end

  def perform_manager_salary_transaction(code, reverse: false)
    from_account, to_account = reverse ? 
      [DoubleEntry.account(:salary, scope: admin_user_id), DoubleEntry.account(:cash)] :
      [DoubleEntry.account(:cash), DoubleEntry.account(:salary, scope: admin_user_id)]

    price = reverse ? (self.price_was || self.price) : self.price
    salary = price * 0.5

    DoubleEntry.transfer(
      Money.new(salary * 100),
      from: from_account,
      to: to_account,
      code: code
    )
  end

  def perform_order_paid_transaction(code, reverse: false)
    from_account, to_account = reverse ?
      [DoubleEntry.account(:cash), DoubleEntry.account(:external)] :
      [DoubleEntry.account(:external), DoubleEntry.account(:cash)]

    price = reverse ? (self.price_was || self.price) : self.price

    DoubleEntry.transfer(
      Money.new(price * 100),
      from: from_account,
      to: to_account,
      code: code
    )
  end

  def perform_order_unpaid_transaction(code, reverse: false)
    from_account, to_account = reverse ? 
      [DoubleEntry.account(:accounts_receivable, scope: id), DoubleEntry.account(:external)] :
      [DoubleEntry.account(:external), DoubleEntry.account(:accounts_receivable, scope: id)]

    price = reverse ? (self.price_was || self.price) : self.price

    DoubleEntry.transfer(
      Money.new(price * 100),
      from: from_account,
      to: to_account,
      code: code
    )
  end

  def perform_update_order_transaction(code, reverse: false)
    from_account, to_account = reverse ? 
    [DoubleEntry.account(:cash), DoubleEntry.account(:accounts_receivable, scope: id)] :
    [DoubleEntry.account(:accounts_receivable, scope: id), DoubleEntry.account(:cash)]

    price = reverse ? (self.price_was || self.price) : self.price

    DoubleEntry.transfer(
      Money.new(price * 100),
      from: from_account,
      to: to_account,
      code: code
    )
  end
end