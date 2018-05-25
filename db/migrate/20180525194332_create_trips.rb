class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer     :duration
      t.datetime    :start_date
      t.datetime    :end_date
      t.references  :end_station
      t.references  :start_station
      t.integer     :bike_id
      t.string      :subscription_type
      t.integer     :zip_code
    end

    add_foreign_key :trips, :stations, column: :end_station_id, primary_key: :id
    add_foreign_key :trips, :stations, column: :start_station_id, primary_key: :id
  end
end
