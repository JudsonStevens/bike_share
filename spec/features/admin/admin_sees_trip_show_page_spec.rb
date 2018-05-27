require 'rails_helper'

describe 'Visit trip show page' do
  describe 'as an admin' do
    it 'can see what a regular users sees' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

      visit trip_path(trip)

      expect(page).to have_content(trip.duration)
      expect(page).to have_content(trip.start_date)
      expect(page).to have_content(trip.end_date)
      expect(page).to have_content(trip.bike_id)
      expect(page).to have_content(trip.subscription_type)
    end

    it 'can see a delete button for the current trip' do
      admin = User.create!(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      station = Station.create!(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip = Trip.create!(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

      visit trip_path(trip)

      expect(page).to have_button('Delete Trip')
    end

    it 'can see an edit button on an existing trip' do
      admin = User.create!(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      station = Station.create!(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip = Trip.create!(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

      visit trip_path(trip)

      expect(page).to have_button('Edit Trip')
    end
  end

  describe 'as a regular user' do
    it'cannot see an edit button or delete button on show page' do
      user = User.create!(first_name: 'Willy', last_name: 'Billiams', address:'123 user street', username:'user', password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      station = Station.create!(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip = Trip.create!(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

      visit trip_path(trip)

      expect(page).to_not have_button('Edit Trip')
      expect(page).to_not have_button('Delete Trip')
    end
  end
end
