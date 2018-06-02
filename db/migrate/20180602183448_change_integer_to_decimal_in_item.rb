class ChangeIntegerToDecimalInItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :price, :integer
    add_column :items, :price, :decimal, precision: 14, scale: 2
  end
end
