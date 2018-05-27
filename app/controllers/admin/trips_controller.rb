class Admin::TripsController < Admin::BaseController

  def show
  end
  
  def edit
    trip = Trip.find(params[:id])
  end

  def update
    require 'pry'; binding.pry
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to trips_path
  end
end
