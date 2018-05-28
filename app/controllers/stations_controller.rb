class StationsController < ApplicationController
  def show
    @station = Station.friendly.find(params[:id])
  end

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
    redirect_to "/#{@station.name}"
  end
end
