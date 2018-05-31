require 'rails_helper'

describe 'Visitor visits trip show page' do
  it 'can see a trip and its attributes' do
    station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
    trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code:50000 )

    visit trip_path(trip)

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date.strftime("%A, %m/%d/%Y"))
    expect(page).to have_content(trip.end_date.strftime("%A, %m/%d/%Y"))
    expect(page).to have_content(trip.bike_id)
    expect(page).to have_content(trip.subscription_type)
  end
end
