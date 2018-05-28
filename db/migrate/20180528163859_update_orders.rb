class UpdateOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :quantity
    add_column :item_orders, :quantity, :integer
  end
end
