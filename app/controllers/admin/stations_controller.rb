class Admin::StationsController < Admin::BaseController
  def show
    redirect_to "/#{params[:id]}"
  end
end