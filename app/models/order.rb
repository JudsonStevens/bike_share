class Order < ApplicationRecord
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
  validates_presence_of :status


  def cancel_order
    order.status = 'cancelled'
  end

  def mark_as_paid
    order.status = 'paid'
  end

  def mark_as_completed
    order.status = 'completed'
  end
end
