class CreateItemOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :item_orders do |t|
      t.belongs_to    :items, index: true, foreign_key: true
      t.belongs_to    :orders, index: true, foreign_key: true
    end
  end
end
