class Admin::TripsController < Admin::BaseController

  def edit
    trip = Trip.find(params[:id])
  end

  def update
  end

  def destroy
<<<<<<< HEAD
=======
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to trips_path
>>>>>>> finished testing that admin can see edit/delete while user cannot
  end
end
