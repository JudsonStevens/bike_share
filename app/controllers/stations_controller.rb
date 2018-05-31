class StationsController < ApplicationController
  def show
    @station = Station.friendly.find(params[:id])
    if @station.start_stations != [] || @station.end_stations != []
      @frequent_destination = Station.find(@station.frequent_destination_station[0]).name
      @frequent_origination = Station.find(@station.frequent_origination_station[0]).name
    end
  end

  def index
    @stations = Station.all
  end
end
