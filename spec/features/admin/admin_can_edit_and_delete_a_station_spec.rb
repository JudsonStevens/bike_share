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


    end

    it 'can delete a specific station from station index and be returned to index with flash message' do

    end
  end
end