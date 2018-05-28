require 'rails_helper'

describe 'Visit trip show page' do
  describe 'as an admin' do
    it 'can delete a trip' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000 )
      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000 )

      visit trip_path(trip1)

      click_on 'Delete Trip'

      expect(current_path).to eq(trips_path)
    end
  end
end
