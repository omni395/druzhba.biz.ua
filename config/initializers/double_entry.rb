require 'double_entry'

DoubleEntry.configure do |config|
  # Use json(b) column in double_entry_lines table to store metadata instead of separate metadata table
  config.json_metadata = true

  config.define_accounts do |accounts|
    accounts.define(identifier: :cash)
    accounts.define(identifier: :expense, scope_identifier: :expense_category)
    accounts.define(identifier: :customer, scope_identifier: :customer)
    accounts.define(identifier: :salary, scope_identifier: :admin_user)
  end

  config.define_transfers do |transfers|
    transfers.define(from: :customer, to: :cash, code: :order_payment)
    transfers.define(from: :cash, to: :expense, code: :expense)
    transfers.define(from: :cash, to: :salary, code: :manager_salary)
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
