require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'navigates to admin new station to create a new station' do
      name = "New Station"
      city = "Denver"
      dock_count = 15

      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit(new_admin_station_path)

      fill_in('station[name]', with: name)
      fill_in('station[city]', with: city)
      fill_in('station[dock_count]', with: dock_count)

      click_on('Create Station')

      expect(current_path).to eq(station_path(Station.last))

      expect(page).to have_content(name)
      expect(page).to have_content(city)
      expect(page).to have_content(dock_count)
    end
  end
end


