class Item < ApplicationRecord
  has_many :item_orders
  has_many :orders, through: :item_orders
  validates_presence_of :price, :image, :description
  validates :title, presence: true, uniqueness: true
end