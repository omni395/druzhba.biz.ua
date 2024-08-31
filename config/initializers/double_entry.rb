require 'double_entry'

DoubleEntry.configure do |config|
  # Use json(b) column in double_entry_lines table to store metadata instead of separate metadata table
  config.json_metadata = true

  config.define_accounts do |accounts|
    accounts.define(identifier: :cash)
    accounts.define(identifier: :revenue)
    accounts.define(identifier: :expense, scope_identifier: ->(expense_category_id) { expense_category_id })
    accounts.define(identifier: :salary, scope_identifier: ->(user_id) { user_id })
    accounts.define(identifier: :accounts_receivable, scope_identifier: ->(order_id) { order_id })
  end

  config.define_transfers do |transfers|
    transfers.define(from: :cash, to: :expense, code: :expense_payment)
    transfers.define(from: :expense, to: :cash, code: :expense_refund)
    transfers.define(from: :cash, to: :salary, code: :manager_salary)
    transfers.define(from: :cash, to: :revenue, code: :order_payment)
    transfers.define(from: :revenue, to: :cash, code: :order_refund)
    transfers.define(from: :accounts_receivable, to: :cash, code: :receivable_payment)
    transfers.define(from: :accounts_receivable, to: :revenue, code: :order_cancellation)
    transfers.define(from: :salary, to: :cash, code: :salary_refund)
  end

  # config.define_accounts do |accounts|
  #   user_scope = ->(user) do
  #     raise 'not a User' unless user.class.name == 'User'
  #     user.id
  #   end
  #   accounts.define(identifier: :savings,  scope_identifier: user_scope, positive_only: true)
  #   accounts.define(identifier: :checking, scope_identifier: user_scope)
  # end
  #
  # config.define_transfers do |transfers|
  #   transfers.define(from: :checking, to: :savings,  code: :deposit)
  #   transfers.define(from: :savings,  to: :checking, code: :withdraw)
  # end
end
