class Item < ApplicationRecord
  has_many :item_orders
  has_many :orders, through: :item_orders
  validates_presence_of :description
  validates :price, numericality: {greater_than: 0}, presence: true
  validates :title, presence: true, uniqueness: {case_sensitive: false}
end
