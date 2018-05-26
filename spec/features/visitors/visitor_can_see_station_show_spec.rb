require 'rails_helper'

describe 'Visitor' do
  context 'they visit a station show page' do
    it 'should show the ' do
      station = Station.create(name: 'City Park North', dock_count: 3, city: 'Denver', installation_date: '2014-09-21T16:39:57-8:00'



      visit station_path(station)


    end


    end
  end
end
