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
      @trips = Trip.all
    end
  end
end
