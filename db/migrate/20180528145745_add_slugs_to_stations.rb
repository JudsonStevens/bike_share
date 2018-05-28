class AddSlugsToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :slug, :string
    add_index :stations, :slug, unique: true
  end
end
