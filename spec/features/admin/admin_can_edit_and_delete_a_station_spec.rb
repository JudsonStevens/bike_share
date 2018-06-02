require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'can edit a specific station and be taken to that stations show page with a flash message' do
      name = "New Station"
      city = "Denver"
      dock_count = 15

      station = Station.create(name: 'Old Station', city: 'Boston', dock_count: 13, installation_date: Time.strptime("08/15/2018", "%m/%d/%Y"))
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit(edit_admin_station_path(station))

      fill_in('station[name]', with: name)
      fill_in('station[city]', with: city)
      fill_in('station[dock_count]', with: dock_count)
      
      click_on('Update Station')

      expect(current_path).to eq(station_path(station))
      expect(page).to have_content(name)
      expect(page).to have_content(city)
      expect(page).to have_content(dock_count)
      expect(page).to_not have_content(station.name)
      expect(page).to_not have_content(station.city)
      expect(page).to_not have_content(station.dock_count)

      expect(page).to have_content("You have updated #{name} station!")
    end

    it 'can delete a specific station from station index and be returned to index with flash message' do
      station = Station.create(name: 'Old Station', city: 'Boston', dock_count: 13, installation_date: Time.strptime("08/15/2018", "%m/%d/%Y"))
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit(stations_path)

      click_on('Delete Station')

      expect(current_path).to eq(stations_path)
      expect(page).to_not have_content(station.city)
      expect(page).to_not have_content(station.dock_count)

      expect(page).to have_content("#{station.name} was successfully deleted!")
    end
  end
end