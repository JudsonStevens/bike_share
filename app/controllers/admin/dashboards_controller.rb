class DashboardsController < ApplicationController

  def show
    if current_admin?
    redirect_to "/admin/bike-shop"
  else
    redirect_to login_path
  end
  end
end
