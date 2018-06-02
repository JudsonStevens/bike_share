require 'rails_helper'

describe 'User' do
  context 'who is logged in' do
    it 'can see all relevant information on the trips dashboard' do
      user1 = User.create(first_name: 'Charles', last_name: 'Xavier', username: 'Charles@gmail.com', password: '123', address: '1212 College Lane')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      
      station1 = Station.create(name:'Turing Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'G School Station', dock_count: 4, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station3 = Station.create(name:'Red Rock', dock_count: 8, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station4 = Station.create(name:'Holy Heck', dock_count: 3, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station3.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station4.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station4.id, start_station_id: station4.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station4.id, start_station_id: station2.id, zip_code:60000 )

      visit(trips_dashboard_path)

      # Average Trip Duration
      expect(page).to have_content(Trip.average(:duration).round)
      # Longest Trip
      expect(page).to have_content(Trip.maximum(:duration))
      # Shortest Trip
      expect(page).to have_content(Trip.minimum(:duration))
      # Station with most rides as a starting station
      expect(page).to have_content(station1.name)
      # Station with the most rides as an end station station
      expect(page).to have_content(station4.name)
      # Bike with the most rides
      expect(page).to have_content(trip.bike_id)
      # Number of rides for most ridden bike
      expect(page).to have_content("3")
      # Least Ridden Bike
      expect(page).to have_content(trip5.bike_id)
      # Number of rides for least ridden bike
      expect(page).to have_content("1")
      # Subscription type breakdown
      expect(page).to have_content(trip.subscription_type)
      # Count of subscription
      expect(page).to have_content("6")
      # Date with highest amount of trips
      expect(page).to have_content(trip3.start_date.strftime("%A, %m/%d/%Y"))
      # Date with lowest amount of trips
      expect(page).to have_content(trip3.start_date.strftime("%A, %m/%d/%Y"))
    end
  end
end
