class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :orders

  def has_role?(role)
    self.role == role
    #current_admin_user && current_admin_user.has_role?(role)
  end

  def month_salary(user)
    Order.where(admin_user: user).where(updated_at: Date.today.at_beginning_of_month..Date.tomorrow).pluck(:price).sum
  end
end
