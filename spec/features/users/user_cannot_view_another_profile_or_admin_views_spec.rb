require 'rails_helper'

describe 'User' do
  context 'logs in' do
    it 'and cannot see another users profile or go to admin views' do
      user1 = User.create(first_name: 'Charles', last_name: 'Xavier', username: 'Charles@gmail.com', password: '123', address: '1212 College Lane')
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit(dashboard_path(user1))

      expect(page).to have_content(user1.first_name)
      expect(page).to have_content(user1.last_name)

      visit(admin_trip_path(trip1))

      expect(page).to have_content("The page you were looking for doesn't exist")
      expect(page).to have_http_status(404)
    end
  end
end
