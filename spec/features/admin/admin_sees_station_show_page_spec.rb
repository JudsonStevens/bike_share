require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'can visit the station show page and see the information about that station along with an edit and delete button' do
      admin = User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station1 = Station.create(name: 'City Park West', dock_count: 2, city: 'Denver', installation_date: '1996-12-19T16:39:57-08:0')

      visit(admin_station_path(station1))

      expect(current_path).to eq("/city-park-west")
      expect(page).to have_content(station1.name)
      expect(page).to have_content(station1.dock_count)
      expect(page).to have_content(station1.city)
      expect(page).to have_content(station1.installation_date)
      expect(page).to have_link('Edit This Station')
      expect(page).to have_link('Delete This Station')
    end
  end
end