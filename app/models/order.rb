# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user
  has_one :expense, dependent: :destroy

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  scope :order_paid, -> { where(paid: paid) }

  after_commit :create_double_entry_transaction, on: :create
  after_commit :update_double_entry_transaction, on: :update, if: :saved_change_to_status?
  after_commit :remove_double_entry_transaction, on: :destroy

  private

  def create_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:revenue),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      if paid?
        process_paid_order
      else
        process_unpaid_order
      end
    end
  end

  def update_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:revenue),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      if saved_change_to_status?
        if paid?
          process_order_paid
        else
          process_order_unpaid
        end
      elsif saved_change_to_price?
        update_order_amount
      end
    end
  end

  def remove_double_entry_transaction
    DoubleEntry.lock_accounts(
      DoubleEntry.account(:cash),
      DoubleEntry.account(:revenue),
      DoubleEntry.account(:accounts_receivable, scope: id),
      DoubleEntry.account(:salary, scope: admin_user_id)
    ) do
      if paid?
        reverse_paid_order
      else
        reverse_unpaid_order
      end
    end
  end

  def process_paid_order
    if admin_user.manager?
      manager_amount = (price * 0.5).round(2)
      cash_amount = price - manager_amount

      DoubleEntry.transfer(
        Money.new(manager_amount * 100, 'USD'),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:salary, scope: admin_user_id),
        code: :manager_salary
      )

      DoubleEntry.transfer(
        Money.new(cash_amount * 100, 'USD'),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:revenue),
        code: :order_payment
      )
    else
      DoubleEntry.transfer(
        Money.new(price * 100, 'USD'),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:revenue),
        code: :order_payment
      )
    end
  end

  def process_unpaid_order
    DoubleEntry.transfer(
      Money.new(price * 100, 'USD'),
      from: DoubleEntry.account(:revenue),
      to: DoubleEntry.account(:accounts_receivable, scope: id),
      code: :order_unpaid
    )
  end

  def process_order_paid
    DoubleEntry.transfer(
      Money.new(price * 100, 'USD'),
      from: DoubleEntry.account(:accounts_receivable, scope: id),
      to: DoubleEntry.account(:cash),
      code: :order_paid
    )
    process_paid_order
  end

  def process_order_unpaid
    reverse_paid_order
    process_unpaid_order
  end

  def update_order_amount
    old_price = price_before_last_save
    price_difference = price - old_price

    if paid?
      update_paid_order_amount(price_difference)
    else
      update_unpaid_order_amount(price_difference)
    end
  end

  def update_paid_order_amount(price_difference)
    if admin_user.manager?
      manager_amount = (price_difference * 0.5).round(2)
      cash_amount = price_difference - manager_amount

      DoubleEntry.transfer(
        Money.new(manager_amount * 100, 'USD'),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:salary, scope: admin_user_id),
        code: :manager_salary
      )

      DoubleEntry.transfer(
        Money.new(cash_amount * 100, 'USD'),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:revenue),
        code: :order_payment
      )
    else
      DoubleEntry.transfer(
        Money.new(price_difference * 100, 'USD'),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:revenue),
        code: :order_payment
      )
    end
  end

  def update_unpaid_order_amount(price_difference)
    DoubleEntry.transfer(
      Money.new(price_difference * 100, 'USD'),
      from: DoubleEntry.account(:revenue),
      to: DoubleEntry.account(:accounts_receivable, scope: id),
      code: :order_unpaid
    )
  end

  def reverse_paid_order
    if admin_user.manager?
      manager_amount = (price * 0.5).round(2)
      cash_amount = price - manager_amount

      DoubleEntry.transfer(
        Money.new(manager_amount * 100, 'USD'),
        from: DoubleEntry.account(:salary, scope: admin_user_id),
        to: DoubleEntry.account(:cash),
        code: :manager_salary
      )

      DoubleEntry.transfer(
        Money.new(cash_amount * 100, 'USD'),
        from: DoubleEntry.account(:revenue),
        to: DoubleEntry.account(:cash),
        code: :order_refund
      )
    else
      DoubleEntry.transfer(
        Money.new(price * 100, 'USD'),
        from: DoubleEntry.account(:revenue),
        to: DoubleEntry.account(:cash),
        code: :order_refund
      )
    end
  end

  def reverse_unpaid_order
    DoubleEntry.transfer(
      Money.new(price * 100, 'USD'),
      from: DoubleEntry.account(:accounts_receivable, scope: id),
      to: DoubleEntry.account(:revenue),
      code: :order_unpaid
    )
  end

end
