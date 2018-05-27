class TripsController < ApplicationController

  def index
    @trips = Trip.all.paginate(:page => params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end


end
