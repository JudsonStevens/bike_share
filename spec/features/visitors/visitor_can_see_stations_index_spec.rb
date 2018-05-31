require 'rails_helper'

describe 'Visitor' do
  context 'they visit the stations index' do
    it 'should show a list of stations with each stations information' do

      station_1 = Station.create(name: 'City Park West', dock_count: 2, city: 'Denver', installation_date: '1996-12-19T16:39:57-08:0')
      station_2 = Station.create(name: 'Coors Field', dock_count: 4, city: 'Denver', installation_date: '2000-12-19T16:39:57-08:00')

      visit stations_path

      expect(page).to have_content(station_1.name)
      expect(page).to have_content(station_1.dock_count)
      expect(page).to have_content(station_1.city)
      expect(page).to have_content(station_1.installation_date.strftime("%A, %m/%d/%Y"))
      expect(page).to have_content(station_2.name)
      expect(page).to have_content(station_2.dock_count)
      expect(page).to have_content(station_2.city)
      expect(page).to have_content(station_2.installation_date.strftime("%A, %m/%d/%Y"))
    end
  end
end
