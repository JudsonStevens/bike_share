class Admin::StationsController < Admin::BaseController
  def show
    redirect_to ("/stations/#{params[:id]}")
  end
end