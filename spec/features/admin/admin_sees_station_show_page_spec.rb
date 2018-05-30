require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'can visit the station show page and see the information about that station along with an edit and delete button' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station1 = Station.create(name:'Turing Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'G School Station', dock_count: 4, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station3 = Station.create(name:'Red Rock', dock_count: 8, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station4 = Station.create(name:'Holy Heck', dock_count: 3, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      Trip.create(duration: 150, start_date: '2018-05-26 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station3.id, zip_code:50000 )
      Trip.create(duration: 110, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station4.id, zip_code:50000 )
      Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station4.id, zip_code:70000 )
      Trip.create(duration: 180, start_date: '2018-05-21 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station2.id, zip_code:60000 )

      visit(admin_station_path(station1))

      expect(current_path).to eq("/stations/#{station1.name.parameterize}")
      expect(page).to have_content(station1.name)
      expect(page).to have_content(station1.dock_count)
      expect(page).to have_content(station1.city)
      expect(page).to have_content(station1.installation_date.strftime("%A, %m/%d/%Y"))
      expect(page).to have_link('Edit This Station')
      expect(page).to have_link('Delete This Station')
    end
  end
end