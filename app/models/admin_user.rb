# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  enum role: { admin: 0, manager: 1 }, _prefix: true

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  @skip = false

  def skip_notifications!
    skip_confirmation_notification!
    @skip = true
  end

  def email_changed?
    return false if @skip

    super
  end

  def encrypted_password_changed?
    return false if @skip

    super
  end
end
