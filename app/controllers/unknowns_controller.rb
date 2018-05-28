class UnknownsController < ApplicationController
  def index
    render file: 'public/404.html', status: :not_found
  end
end
