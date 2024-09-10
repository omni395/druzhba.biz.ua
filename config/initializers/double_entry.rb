require 'double_entry'

DoubleEntry.configure do |config|
  config.define_accounts do |accounts|
    accounts.define(identifier: :customer, scope_identifier: ->(customer_id) { customer_id })
    accounts.define(identifier: :cash)
    accounts.define(identifier: :accounts_receivable, scope_identifier: ->(order_id) { order_id })
    accounts.define(identifier: :salary, scope_identifier: ->(user_id) { user_id })
    accounts.define(identifier: :expense, scope_identifier: ->(expense_category_id) { expense_category_id })
  end

  config.define_transfers do |transfers|
    transfers.define(from: :cash, to: :expense, code: :expense_payment)
    transfers.define(from: :expense, to: :cash, code: :expense_refund)

    transfers.define(from: :customer, to: :cash, code: :order_payment)
    transfers.define(from: :customer, to: :accounts_receivable, code: :order_receivable)
    transfers.define(from: :accounts_receivable, to: :cash, code: :order_payment)
    transfers.define(from: :cash, to: :accounts_receivable, code: :order_unpaid)
    transfers.define(from: :customer, to: :cash, code: :order_price_adjustment)
    transfers.define(from: :customer, to: :accounts_receivable, code: :order_receivable_adjustment)
    transfers.define(from: :cash, to: :salary, code: :salary_assignment)
    transfers.define(from: :salary, to: :cash, code: :salary_reversal)
    transfers.define(from: :cash, to: :salary, code: :salary_adjustment)
    transfers.define(from: :cash, to: :customer, code: :order_refund)
    transfers.define(from: :accounts_receivable, to: :customer, code: :order_receivable_reversal)
  end
end