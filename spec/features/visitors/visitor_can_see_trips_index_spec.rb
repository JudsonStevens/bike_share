require 'rails_helper'

describe 'Visitor' do
  context 'they visit a trips index page' do
    it 'should show the first 30 trips with all attributes' do
      station_1 = Station.create(name: 'City Park West', dock_count: 5, city: 'Denver', installation_date: '2013-09-21T16:39:57-8:00')
      station_2 = Station.create(name: 'City Park North', dock_count: 4, city: 'Denver', installation_date: '2013-10-21T16:39:57-8:00')
      trip = Trip.create(duration: 23, start_date: '2014-09-21T16:39:57-8:00', end_date: '2014-09-21T16:55:57-8:00', end_station_id: station_1.id, start_station_id: station_2.id, bike_id: 4, subscription_type: 'gold', zip_code: '08830')



    end
    it 'should have a button to show more trips' do

    end
  end
end
