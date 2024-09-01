# frozen_string_literal: true

AdminUser.create(email: 'admin@example.com', password: '12345678', role: 0)
AdminUser.create(email: 'manager@example.com', password: '12345678', role: 1)
