class User < ApplicationRecord
  has_many :orders
  validates_presence_of :first_name, :last_name, :address, :password
  validates :username, presence: true, uniqueness: true
  validates_confirmation_of :password
  enum role: [:default, :admin]
  has_secure_password

  def cancelled_orders
    orders.where(status: 'cancelled')
  end

  def completed_orders
    orders.where(status: 'completed')
  end

  def paid_orders
    orders.where(status: 'paid')
  end

  def ordered_orders
    orders.where(status: 'ordered')
  end 
end
