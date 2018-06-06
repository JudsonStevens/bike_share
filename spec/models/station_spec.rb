require 'rails_helper'

describe Station, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
  end

  describe 'Relationships' do
    it { should have_many(:start_stations).class_name("Trip") }
    it { should have_many(:end_stations).class_name("Trip") }
  end

  describe 'Instance Methods' do
    it 'can sort by id' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      station3 = Station.create(name:'New Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')

      expect(Station.sort_by_id.first).to eq(station)
      expect(Station.sort_by_id.last).to eq(station3)
    end
  end

  describe 'Instance Methods' do
    it 'can sum starting trips length' do
      station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station1.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:60000 )

      expect(station1.sum_starting_trips).to eq(4)
    end

    it 'can sum ending trips length' do
      station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station1.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:60000 )

      expect(station1.sum_ending_trips).to eq(1)
    end

    it 'can get the frequent destination station' do
      station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station1.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:60000 )

      expect(Station.find(station1.frequent_destination_station.first)).to eq(station2)
    end

    it 'can get the frequent origination station' do
      station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station1.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:60000 )

      expect(Station.find(station1.frequent_origination_station.first)).to eq(station1)
    end

    it 'can calculate the date with most trip starts' do
      station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station1.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:60000 )

      expect(station1.date_with_most_trip_starts.to_s).to eq("2018-05-24 14:40:00 UTC")
    end

    it 'can calculate the most frequent zip code' do
      station1 = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'During Station', dock_count: 2, city: 'Denver', installation_date:'2018-05-03 01:00:00 UTC')
      trip = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip2 = Trip.create(duration: 150, start_date: '2018-05-23 14:40:00' , end_date: '2018-05-30 14:48:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip3 = Trip.create(duration: 130, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:49:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station1.id, start_station_id: station1.id, zip_code:50000 )
      trip4 = Trip.create(duration: 110, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:43:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station1.id, zip_code:50000 )
      trip5 = Trip.create(duration: 190, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:44:01', bike_id: 2, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:70000 )
      trip6 = Trip.create(duration: 180, start_date: '2018-05-22 14:40:00' , end_date: '2018-05-24 14:47:01', bike_id: 3, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station2.id, zip_code:60000 )

      expect(station1.most_freq_zip_codes).to eq(50000)
    end
  end
end