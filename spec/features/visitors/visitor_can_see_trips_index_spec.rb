require 'rails_helper'

describe 'Visitor' do
  context 'they visit a trips index page' do
    it 'should show the first 30 trips with all attributes' do

      trips = create_list(:trip, 30)

      visit station_path(station)
      expect(page).to have_content(trips[29])
      expect(page).to have_content(trips.first.duration)
      expect(page).to have_content(trips.first.start_date)
      expect(page).to have_content(trips.first.end_date)
      expect(page).to have_content(trips.first.end_station_id)
      expect(page).to have_content(trips.first.start_station_id)
      expect(page).to have_content(trips.first.bike_id)
      expect(page).to have_content(trips.first.subscription_type)
      expect(page).to have_content(trips.first.zip_code)

      expect(page).to have_content(trips.last.duration)
      expect(page).to have_content(trips.last.start_date)
      expect(page).to have_content(trips.last.end_date)
      expect(page).to have_content(trips.last.end_station_id)
      expect(page).to have_content(trips.last.start_station_id)
      expect(page).to have_content(trips.last.bike_id)
      expect(page).to have_content(trips.last.subscription_type)
      expect(page).to have_content(trips.last.zip_code)
    end
    it 'should have a button to show more trips' do

    end
  end
end
