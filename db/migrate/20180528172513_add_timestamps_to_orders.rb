class AddTimestampsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :orders, default: DateTime.now
    change_column_default :orders, :created_at, nil
    change_column_default :orders, :updated_at, nil
  end
end
