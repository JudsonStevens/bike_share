require 'rails_helper'

describe 'Visitor visits trip show page' do
  it 'can see a trip and its attributes' do
    station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', datetime:'2018-05-12 01:00:00 UTC')
    trip = station.trips.create(duration: 120, )
  end
end
