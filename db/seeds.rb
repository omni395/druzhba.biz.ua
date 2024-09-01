# frozen_string_literal: true

AdminUser.create(name: 'Admin', email: 'admin@example.com', password: '12345678', role: 0)
AdminUser.create(name: 'Manager', email: 'manager@example.com', password: '12345678', role: 1)

ExpenseCategory.create(title: 'Оренда', description: 'Оренда приміщення')
ExpenseCategory.create(title: 'Комунальні платежі', description: 'Комунальні платежі')
ExpenseCategory.create(title: 'Податки', description: 'Податки')
ExpenseCategory.create(title: 'Інтернет', description: 'Послуги інтернету')
ExpenseCategory.create(title: 'Мобільний звʼязок', description: 'Мобільний звʼязок')
ExpenseCategory.create(title: 'Поточні витрати', description: 'Поточні витрати')
ExpenseCategory.create(title: 'Інше', description: 'Інші витрати')
