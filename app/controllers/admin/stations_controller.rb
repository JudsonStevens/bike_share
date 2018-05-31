class Admin::StationsController < Admin::BaseController
  def show
    station = Station.friendly.find(params[:id])
    redirect_to station_path(station)
  end

  def new
    @station = Station.new
  end

  def create
    params[:station][:installation_date] = "#{params[:station]["installation_date(2i)"]}/#{params[:station]["installation_date(3i)"]}/#{params[:station]["installation_date(1i)"]}"
    station = Station.new(station_params)
    if station.save
      flash[:success] = "You have created a new station called #{station.name}!"
    end
    redirect_to station_path(station)
  end

  def edit
    @station = Station.friendly.find(params[:id])
  end

  def update
    station = Station.friendly.find(params[:id])
    params[:station][:installation_date] = "#{params[:station]["installation_date(2i)"]}/#{params[:station]["installation_date(3i)"]}/#{params[:station]["installation_date(1i)"]}"
    if station.update(station_params)
      flash[:success] = "You have updated station-#{station.name}!"
    end
    redirect_to station_path(station)
  end

  def destroy
    station = Station.friendly.find(params[:id])
    if station.destroy
      flash[:success] = "station-#{station.id} has been deleted!"
    end
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:city, :installation_date, :name, :dock_count)
  end
end
