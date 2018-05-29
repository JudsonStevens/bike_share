require 'rails_helper'

describe 'Visits the trip index page' do
  describe 'as an admin' do
    it 'sees and can click on an edit button' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )
      trip1 = Trip.create(duration: 90, start_date: '2018-05-01 14:40:00' , end_date: '2018-05-02 14:42:01', bike_id: 2, subscription_type: 'monthly', end_station_id: station.id, start_station_id: station.id, zip_code:50023 )

      visit trips_path
      save_and_open_page

      within("#trip-#{trip1.id}") do
        click_on 'Edit Trip'
      end

      expect(current_path).to eq(edit_admin_trip_path(trip1))
    end
  end
end
