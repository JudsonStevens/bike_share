class Order < ApplicationRecord
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
  validates_presence_of :status

  def self.status_count(status)
    where(status: status).count
  end
end
