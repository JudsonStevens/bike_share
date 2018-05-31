class Admin::StationsController < Admin::BaseController
  def show
    redirect_to ("/stations/#{params[:id]}")
  end

  def new
    @station = Station.new
  end

  def create
    params[:station][:installation_date] = "#{params[:station]["installation_date(2i)"]}/#{params[:station]["installation_date(3i)"]}/#{params[:station]["installation_date(1i)"]}"
    station = Station.new(station_params)
    if station.save
      flash.now[:success] = "You have created a new station!"
    end
    redirect_to station_path(station)
  end

  private

  def station_params
    params.require(:station).permit(:city, :installation_date, :name, :dock_count)
  end
end
