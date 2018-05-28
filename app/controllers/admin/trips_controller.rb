class Admin::TripsController < Admin::BaseController

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    trip = Trip.find(params[:id])
    trip.update(trip_params)

    redirect_to trip_path(trip)
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy

    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :start_date, :end_date, :bike_id, :subscription_type, :start_station_id, :end_station_id, :zip_code)
  end
end
