require 'rails_helper'

describe 'Admin' do
  context 'they visit trips index' do
    it 'can delete a trip off trips index' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station  = Station.create(name: 'City Park West', dock_count: 5, city: 'Denver', installation_date: '2013-09-21T16:39:57-8:00')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000 )

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      visit trips_path

      within("#trip-#{trip2.id}") do
        click_on 'Delete Trip'
      end

      expect(page).to_not have_content(trip2.duration)
    end
  end
end
