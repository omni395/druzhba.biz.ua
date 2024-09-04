# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  scope :order_paid, -> { where(paid: 'inpaid') }

  after_commit :create_double_entry_transaction, on: :create
  after_commit :update_double_entry_transaction, on: :update
  after_commit :remove_double_entry_transaction, on: :destroy

  private

  def create_double_entry_transaction
    DoubleEntry.lock_accounts(*relevant_accounts) do
      if paid == 'inpaid'
        perform_order_paid_transaction(:order_payment)
        perform_salary_transaction if admin_user.role == 'manager'
      else
        perform_order_unpaid_transaction(:order_unpaid)
      end
    end
  end

  def update_double_entry_transaction
    DoubleEntry.lock_accounts(*relevant_accounts) do
      if saved_change_to_paid?
        update_paid_status
      end
      if saved_change_to_admin_user_id?
        update_admin_user
      end
    end
  end

  def remove_double_entry_transaction
    DoubleEntry.lock_accounts(*relevant_accounts) do
      if paid == 'inpaid'
        perform_order_paid_transaction(:order_refund, reverse: true)
        perform_salary_transaction(reverse: true) if admin_user.role == 'manager'
      else
        perform_order_unpaid_transaction(:order_remove, reverse: true)
      end
    end
  end

  def update_paid_status
    if paid == 'inpaid'
      DoubleEntry.transfer(
        Money.new(price * 100),
        from: DoubleEntry.account(:accounts_receivable, scope: id),
        to: DoubleEntry.account(:cash),
        code: :order_to_paid
      )
      perform_salary_transaction if admin_user.role == 'manager'
    else
      DoubleEntry.transfer(
        Money.new(price * 100),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:accounts_receivable, scope: id),
        code: :order_to_unpaid
      )
      perform_salary_transaction(reverse: true) if admin_user.role == 'manager'
    end
  end

  def update_admin_user
    old_admin_user = AdminUser.find(admin_user_id_before_last_save)
    new_admin_user = admin_user

    if old_admin_user.role == 'manager' && new_admin_user.role == 'admin'
      perform_salary_transaction(reverse: true, admin_user_id: admin_user_id_before_last_save)
    elsif old_admin_user.role == 'admin' && new_admin_user.role == 'manager'
      perform_salary_transaction
    end
  end

  def perform_order_paid_transaction(code, reverse: false)
    from_account, to_account = reverse ?
      [DoubleEntry.account(:cash), DoubleEntry.account(:external)] :
      [DoubleEntry.account(:external), DoubleEntry.account(:cash)]

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

    DoubleEntry.transfer(
      Money.new(price * 100),
      from: from_account,
      to: to_account,
      code: code
    )
  end

  def perform_salary_transaction(reverse: false, admin_user_id: self.admin_user_id)
    salary = price * 0.5
    remaining = price - salary

    if reverse
      DoubleEntry.transfer(
        Money.new(salary * 100),
        from: DoubleEntry.account(:salary, scope: admin_user_id),
        to: DoubleEntry.account(:cash),
        code: :salary_refund
      )
    else
      DoubleEntry.transfer(
        Money.new(salary * 100),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:salary, scope: admin_user_id),
        code: :salary_payment
      )
    end

    DoubleEntry.transfer(
      Money.new(remaining * 100),
      from: DoubleEntry.account(:external),
      to: DoubleEntry.account(:cash),
      code: :remaining_payment
    )
  end

  def relevant_accounts
    [
      DoubleEntry.account(:cash),
      DoubleEntry.account(:external),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id),
      DoubleEntry.account(:salary, scope: admin_user_id_was)
    ].compact
  end
end