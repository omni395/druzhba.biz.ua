require 'double_entry'

DoubleEntry.configure do |config|
  config.json_metadata = true

  config.define_accounts do |accounts|
    accounts.define(identifier: :external)
    accounts.define(identifier: :cash)
    accounts.define(identifier: :expense, scope_identifier: ->(expense_category_id) { expense_category_id })
    accounts.define(identifier: :salary, scope_identifier: ->(user_id) { user_id })
    accounts.define(identifier: :accounts_receivable, scope_identifier: ->(order_id) { order_id })
  end
 
  config.define_transfers do |transfers|
    transfers.define(from: :cash, to: :expense, code: :expense_payment)
    transfers.define(from: :expense, to: :cash, code: :expense_refund)
    
    # Зарплата и возврат зарплаты
    transfers.define(from: :cash, to: :salary, code: :salary_payment)
    transfers.define(from: :salary, to: :cash, code: :salary_refund)

    # Заказ. Оплаченный.
    transfers.define(from: :external, to: :cash, code: :order_payment)
    
    # Заказ. Неоплаченный.
    transfers.define(from: :external, to: :accounts_receivable, code: :order_unpaid)

    # Смена статуса заказа
    transfers.define(from: :cash, to: :accounts_receivable, code: :order_to_unpaid)
    transfers.define(from: :accounts_receivable, to: :cash, code: :order_to_paid)

    # Удаление заказа (возврат средств на external)
    transfers.define(from: :cash, to: :external, code: :order_refund)
    transfers.define(from: :accounts_receivable, to: :external, code: :order_remove)

    # Оставшаяся сумма для менеджера (после вычета зарплаты)
    transfers.define(from: :external, to: :cash, code: :remaining_payment)
  end
end