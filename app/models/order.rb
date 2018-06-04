class Order < ApplicationRecord
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
  validates_presence_of :status

  def self.status_count(status)
    where(status: status).count
  end

  def self.ordered
    where(status: 'ordered')
  end

  def self.cancelled
    where(status: 'cancelled')
  end

  def self.completed
    where(status: 'completed')
  end

  def self.paid
    where(status: 'paid')
  end 
end
