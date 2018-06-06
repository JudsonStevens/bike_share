require 'rails_helper'

describe Trip, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :start_station_id }
    it { should validate_presence_of :end_station_id }
    it { should validate_presence_of :subscription_type }
    it { should validate_presence_of :bike_id }
  end

  describe 'Relationships' do
    it { should belong_to(:end_station).class_name("Station") }
    it { should belong_to(:end_station).class_name("Station") }
  end

  describe 'Class Methods' do
    it 'can calculate average ride duration' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      average = (trip1.duration + trip2.duration) / 2

      expect(Trip.average_ride_duration).to eq(average)
    end

    it 'can calculate longest ride' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      longest = trip1.duration

      expect(Trip.longest_ride).to eq(longest)
    end

    it 'can calculate shortest ride' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      shortest = trip2.duration

      expect(Trip.shortest_ride).to eq(shortest)
    end

    it 'can calculate at what station most trips start' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)


      expect(Trip.most_starting_station).to eq(station)
    end

    it 'can calculate at what station most trips end' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')
      station2 = Station.create(name:'Denver Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station2.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station2.id, start_station_id: station.id, zip_code: 60000)


      expect(Trip.most_end_station).to eq(station2)
    end

    it 'can breakdown trips by month' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.month_breakdown.first.first.to_s).to eq("2018-06-01 00:00:00 UTC")
      expect(Trip.month_breakdown.to_a.last.first.to_s).to eq("2018-05-01 00:00:00 UTC")
    end

    it 'can breakdown trips by year' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.year_breakdown.to_a.first.first.to_s).to eq("2018-01-01 00:00:00 UTC")
    end

    it 'most ridden bike' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      trip3 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.most_ridden_bike.first).to eq(2)
    end

    it 'least ridden bike' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      trip3 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.least_ridden_bike.first).to eq(1)
    end

    it 'subsrcription count' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      trip3 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.subscription_count['Daily']).to eq(2)
      expect(Trip.subscription_count['Subscriber']).to eq(1)
    end

    it 'date with the most trips' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      trip3 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.date_with_most_trips.first.to_s).to eq("2018-05-24 14:40:00 UTC")
    end

    it 'date with the least trips' do
      station = Station.create(name:'Turing Station', dock_count: 1, city: 'Denver', installation_date:'2018-05-01 01:00:00 UTC')

      trip1 = Trip.create(duration: 120, start_date: '2018-06-24 14:40:00' , end_date: '2018-06-24 14:42:01', bike_id: 1, subscription_type: 'Subscriber', end_station_id: station.id, start_station_id: station.id, zip_code: 50000)

      trip2 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      trip3 = Trip.create(duration: 90, start_date: '2018-05-24 14:40:00' , end_date: '2018-05-24 14:42:01', bike_id: 2, subscription_type: 'Daily', end_station_id: station.id, start_station_id: station.id, zip_code: 60000)

      expect(Trip.date_with_least_trips.first.to_s).to eq("2018-06-24 14:40:00 UTC")
    end
  end
end
