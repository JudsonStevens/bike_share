require 'rails_helper'

describe 'as an admin' do
  it 'can create a new trip' do
    duration = 90
    start_date = '05/01/2018 14:40:00'
    end_date = '05/01/2018 16:40:00'
    bike_id = 1
    subscription_type = 'Monthly'
    zip_code = 12345
    success = "You have created a new trip!"

    station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

    station2 = Station.create(name:'Denver Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

    admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path


    fill_in 'trip[duration]', with: duration
    fill_in 'trip[start_date]', with: start_date
    fill_in 'trip[end_date]', with: end_date
    fill_in 'trip[bike_id]', with: bike_id
    select 'Turing Station', from: 'trip_start_station_id'
    select 'Denver Station', from: 'trip_end_station_id'
    fill_in 'trip[subscription_type]', with: subscription_type
    fill_in 'trip[zip_code]', with: zip_code
    click_on 'Create Trip'

    trip = Trip.last

    expect(current_path).to eq(trip_path(trip))
    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date.strftime("%A, %m/%d/%Y"))
    expect(page).to have_content(trip.end_date.strftime("%A, %m/%d/%Y"))
    expect(page).to have_content(trip.bike_id)
    expect(page).to have_content(station1.name)
    expect(page).to have_content(station2.name)
    expect(page).to have_content(trip.subscription_type)
    expect(page).to have_content(trip.zip_code)
    expect(page).to have_content(success)
  end
end
