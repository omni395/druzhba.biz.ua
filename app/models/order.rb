# frozen_string_literal: true

class Order < ApplicationRecord
  include FormattedField

  belongs_to :customer
  belongs_to :admin_user

  has_many :order_details, class_name: 'order_details', foreign_key: 'reference_id'

  scope :order_paid, -> { where(paid: 'inpaid') }


  enum status: { new: 0, in_work: 1, done: 2, rejected: 3 }, _prefix: true
  enum paid: { unpaid: 0, inpaid: 1 }, _prefix: true

  after_commit :create_initial_transaction, on: :create
  after_commit :update_transaction, on: :update
  after_commit :reverse_transactions, on: :destroy

  private

  def create_initial_transaction
    if paid == 'inpaid'
      create_paid_transaction
    else
      create_unpaid_transaction
    end
  end

  def create_paid_transaction
    DoubleEntry.transfer(
      Money.new(price * 100),
      from: DoubleEntry.account(:customer, scope: customer),
      to: DoubleEntry.account(:cash),
      code: :order_payment
    )
    assign_salary_to_responsible_user
  end

  def create_unpaid_transaction
    DoubleEntry.transfer(
      Money.new(price * 100),
      from: DoubleEntry.account(:customer, scope: customer),
      to: DoubleEntry.account(:accounts_receivable, scope: id),
      code: :order_receivable
    )
  end

  def update_transaction
    if saved_change_to_paid?
      handle_status_change
    elsif saved_change_to_price?
      handle_price_change
    elsif saved_change_to_admin_user_id?
      handle_responsible_user_change
    end
  end

  def handle_status_change
    if paid == 'inpaid'
      DoubleEntry.transfer(
        Money.new(price * 100),
        from: DoubleEntry.account(:accounts_receivable, scope: id),
        to: DoubleEntry.account(:cash),
        code: :order_payment
      )
      assign_salary_to_responsible_user
    else
      DoubleEntry.transfer(
        Money.new(price * 100),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:accounts_receivable, scope: id),
        code: :order_unpaid
      )
      reverse_salary_assignment
    end
  end

  def handle_price_change
    price_difference = price - price_before_last_save
    if paid == 'inpaid'
      DoubleEntry.transfer(
        Money.new(price_difference * 100),
        from: DoubleEntry.account(:customer, scope: customer),
        to: DoubleEntry.account(:cash),
        code: :order_price_adjustment
      )
      update_salary_assignment(price_difference)
    else
      DoubleEntry.transfer(
        Money.new(price_difference * 100),
        from: DoubleEntry.account(:customer, scope: customer),
        to: DoubleEntry.account(:accounts_receivable, scope: id),
        code: :order_receivable_adjustment
      )
    end
  end

  def handle_responsible_user_change
    return unless paid == 'inpaid'

    old_user = AdminUser.find_by(id: admin_user_id_before_last_save)
    new_user = admin_user

    reverse_salary_assignment(old_user)
    assign_salary_to_responsible_user(new_user)
  end

  def assign_salary_to_responsible_user(user = admin_user)
    return unless user

    salary_amount = user.role == 'manager' ? (price * 0.5) : 0
    DoubleEntry.transfer(
      Money.new(salary_amount * 100),
      from: DoubleEntry.account(:cash),
      to: DoubleEntry.account(:salary, scope: user),
      code: :salary_assignment
    )
  end

  def reverse_salary_assignment(user = admin_user)
    return unless user

    salary_amount = user.role == 'manager' ? (price * 0.5) : 0
    DoubleEntry.transfer(
      Money.new(salary_amount * 100),
      from: DoubleEntry.account(:salary, scope: user),
      to: DoubleEntry.account(:cash),
      code: :salary_reversal
    )
  end

  def update_salary_assignment(price_difference)
    return unless admin_user.role == 'manager'

    salary_difference = price_difference * 0.5
    DoubleEntry.transfer(
      Money.new(salary_difference * 100),
      from: DoubleEntry.account(:cash),
      to: DoubleEntry.account(:salary, scope: admin_user),
      code: :salary_adjustment
    )
  end

  def reverse_transactions
    if paid == 'inpaid'
      DoubleEntry.transfer(
        Money.new(price * 100),
        from: DoubleEntry.account(:cash),
        to: DoubleEntry.account(:customer, scope: customer),
        code: :order_refund
      )
      reverse_salary_assignment
    else
      DoubleEntry.transfer(
        Money.new(price * 100),
        from: DoubleEntry.account(:accounts_receivable, scope: id),
        to: DoubleEntry.account(:customer, scope: customer),
        code: :order_receivable_reversal
      )
    end
  end
end