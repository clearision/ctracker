class CountriesController < ApplicationController
  before_action :authenticate_user!, only: [:visit]

  def visit
    CountryVisitor.new(current_user, permitted_params[:country_codes]).visit!

    render json: { visited_countries: current_user.countries }
  end

  private

    def permitted_params
      params.permit(country_codes: [])
    end
end
