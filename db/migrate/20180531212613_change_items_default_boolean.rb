class ChangeItemsDefaultBoolean < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :is_retired?, :boolean, :default => false
  end
end
