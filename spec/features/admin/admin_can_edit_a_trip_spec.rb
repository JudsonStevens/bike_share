require 'rails_helper'
describe 'Visit trip show page' do
  describe 'as an admin' do
    it 'can edit a trip' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      duration = 90
      start_date = '05/01/2018 14:40:00'
      end_date = '05/01/2018 16:40:00'
      bike_id = 1
      subscription_type = 'Monthly'
      zip_code = 12345

      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')

      end_station_id = station2.id
      start_station_id = station2.id

      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

      success = "You have updated Trip-#{trip.id}!"

      visit trip_path(trip)

      click_on 'Edit Trip'

      fill_in 'trip[duration]', with: duration
      fill_in 'trip[bike_id]', with: bike_id
      select 'Turing Station', from: 'trip_start_station_id'
      select 'During Station', from: 'trip_end_station_id'
      fill_in 'trip[subscription_type]', with: subscription_type
      fill_in 'trip[zip_code]', with: zip_code


      click_on 'Update Trip'


      expect(current_path).to eq(trip_path(trip))
      expect(page).to have_content(duration)
      expect(page).to have_content(Trip.last.start_date.strftime("%A, %m/%d/%Y"))
      expect(page).to have_content(Trip.last.end_date.strftime("%A, %m/%d/%Y"))
      expect(page).to have_content(bike_id)
      expect(page).to have_content(station2.name)
      expect(page).to have_content(station.name)
      expect(page).to have_content(subscription_type)
      expect(page).to have_content(zip_code)
      expect(page).to have_content(success)
    end
  end
end
