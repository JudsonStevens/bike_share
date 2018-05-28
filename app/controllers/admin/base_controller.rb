class Admin::BaseController < ApplicationController
  before_action :is_admin?

  private

  def is_admin?
    render file: 'public/404', status: :not_found if !current_admin?
  end
end
