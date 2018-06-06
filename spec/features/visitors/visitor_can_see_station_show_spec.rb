require 'rails_helper'

describe 'Visitor' do
  context 'they visit a station show page' do
    it 'should show the station information' do
      station = Station.create(name: 'City Park North', dock_count: 3, city: 'Denver', installation_date: '2014-09-21T16:39:57-8:00')

      visit station_path(station)

      expect(current_path).to eq("/stations/#{station.name.parameterize}")
      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date.strftime("%A, %m/%d/%Y"))
    end
  end
end
