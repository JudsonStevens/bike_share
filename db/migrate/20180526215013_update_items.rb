class UpdateItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :is_retired?, :boolean
  end
end
