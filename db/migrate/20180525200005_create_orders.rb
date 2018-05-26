class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string      :status
      t.integer     :quantity
      t.belongs_to  :user, index: true, foreign_key: true
    end
  end
end
