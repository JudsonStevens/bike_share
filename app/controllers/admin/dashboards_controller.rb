class DashboardsController < ApplicationController

  def index
      if current_admin?
      redirect_to "/admin/bike-shop"
    else
      redirect_to login_path
    end
  end

  def show
  end
end
