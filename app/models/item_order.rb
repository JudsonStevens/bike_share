class ItemOrder < ApplicationRecord
  belongs_to :item, foreign_key: "item_id"
  belongs_to :order, foreign_key: "order_id"
end