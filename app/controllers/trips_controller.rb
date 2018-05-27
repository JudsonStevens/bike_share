class TripsController < ApplicationController
  def show
    @trip = Trip.find(params[:id])
  end

  def index
    @trips = Trip.all
  end
end
