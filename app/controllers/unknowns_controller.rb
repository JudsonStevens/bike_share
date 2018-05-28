class UnknownsController < ApplicationController
  def index
    raise ActionController::RoutingError.new(params[:path])
  end
end
