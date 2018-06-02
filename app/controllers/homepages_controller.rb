class HomepagesController < ApplicationController
  def index
  end

  def show
    if request.env['PATH_INFO'] == "/stations-dashboard"
      @station_count = Station.all.count
      @oldest_station = Station.oldest_station
      @most_bikes = Station.most_bikes
      @least_bikes = Station.least_bikes
      @average_bikes = Station.average_bikes
      @newest_station = Station.newest_station
    elsif request.env['PATH_INFO'] == "/trips-dashboard"
      @average_ride_length = Trip.average_ride_duration
      @longest_ride = Trip.longest_ride
      @shortest_ride = Trip.shortest_ride
      @most_start_station = Trip.most_starting_station
      @most_end_station = Trip.most_end_station
      @month_breakdown = Trip.month_breakdown
      @year_breakdown = Trip.year_breakdown
      @most_ridden_bike = Trip.most_ridden_bike
      @least_ridden_bike = Trip.least_ridden_bike
      total_trips = Trip.all.count
      require 'pry'; binding.pry
      @subscription_info = Trip.subscription_count.each { |key, val| return [key, val, ((val/total_trips)*100)]}
    end
  end
end
