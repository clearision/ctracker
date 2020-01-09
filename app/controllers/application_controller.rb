class ApplicationController < ActionController::API
  include UserAuth

  before_action :authenticate_user!, only: [:dashboard]

  def index
    render layout: "layouts/application"
  end

  def dashboard
    presenter = DashboardPresenter.new(current_user)
    render json: {
        currencies: presenter.available_currencies,
        visited_countries: presenter.visited_countries,
        collected_currencies: presenter.collected_currencies
      }
  end
end
