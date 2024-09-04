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
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:external),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      if paid == 'inpaid'
        perform_paid_order_transaction
      else
        perform_unpaid_order_transaction
      end
    end
  end

  def update_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:external),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id),
      DoubleEntry.account(:salary, scope: admin_user_id_was)
    ) do
      if paid_changed?
        update_paid_status
      end
      if admin_user_id_changed?
        update_admin_user
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
        perform_paid_order_transaction(reverse: true)
      else
        perform_unpaid_order_transaction(reverse: true)
      end
    end
  end

  def perform_paid_order_transaction(reverse: false)
    total_amount = Money.new(price * 100)
    
    from_account, to_account = reverse ?
      [DoubleEntry.account(:cash), DoubleEntry.account(:external)] :
      [DoubleEntry.account(:external), DoubleEntry.account(:cash)]

    if admin_user.role == 'manager'
      salary_amount = total_amount * 0.5
      cash_amount = total_amount - salary_amount

      DoubleEntry.transfer(
        salary_amount,
        from: from_account,
        to: DoubleEntry.account(:salary, scope: admin_user_id),
        code: reverse ? :salary_refund : :salary_payment
      )

      DoubleEntry.transfer(
        cash_amount,
        from: from_account,
        to: to_account,
        code: reverse ? :order_refund : :order_payment
      )
    else
      DoubleEntry.transfer(
        total_amount,
        from: from_account,
        to: to_account,
        code: reverse ? :order_refund : :order_payment
      )
    end
  end

  def perform_unpaid_order_transaction(reverse: false)
    from_account, to_account = reverse ? 
      [DoubleEntry.account(:accounts_receivable, scope: id), DoubleEntry.account(:external)] :
      [DoubleEntry.account(:external), DoubleEntry.account(:accounts_receivable, scope: id)]

    DoubleEntry.transfer(
      Money.new(price * 100),
      from: from_account,
      to: to_account,
      code: reverse ? :order_remove : :order_unpaid
    )
  end

  def update_paid_status
    if paid == 'inpaid'
      perform_unpaid_order_transaction(reverse: true)
      perform_paid_order_transaction
    else
      perform_paid_order_transaction(reverse: true)
      perform_unpaid_order_transaction
    end
  end

  def update_admin_user
    old_admin_user = AdminUser.find(admin_user_id_was)
    new_admin_user = admin_user

    if paid == 'inpaid'
      perform_paid_order_transaction(reverse: true)
      perform_paid_order_transaction
    end
  end
end