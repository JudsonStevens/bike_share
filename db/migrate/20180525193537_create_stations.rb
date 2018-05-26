class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string      :name
      t.integer     :dock_count
      t.string      :city
      t.datetime    :installation_date
    end
  end
end
