class DashboardPresenter
  def initialize user
    @user = user
  end

  def available_currencies
    remaining_currencies.preload(:countries).map do |currency|
      {
        id: currency.id,
        code: currency.code,
        name: currency.name,
        countries: available_countries(currency)
      }
    end
  end

  def collected_currencies
    user_currencies = user.user_currencies

    user_currencies
      .preload(:currency)
      .order(created_at: :asc)
      .each_with_index
      .map do |user_currency, index|
        {
          code: user_currency.currency.code,
          name: user_currency.currency.name,
          collected_at: user_currency.created_at.strftime('%T'),
          currencies_collected: index+1
        }
      end
  end

  def visited_countries
    user.countries
  end

  private

    attr_reader :user

    def available_countries currency
      currency.countries.map do |country|
        {
          id: country.id,
          name: country.name,
          code: country.code,
          visited: visited_countries.include?(country)
        }
      end
    end

    def remaining_currencies
      codes = collected_currencies.map { |currency| currency[:code] }

      Currency.where.not(code: codes).preload(:countries)
    end
end
