class CountryVisitor
  def initialize user, country_codes
    @user = user
    @countries_to_visit = Country.where(code: country_codes).entries
  end

  def visit!
    return false if countries_to_visit.blank?

    countries_to_visit.each do |country|
      ActiveRecord::Base.transaction do
        collect_currency!(country.currency) if visit_country!(country)
      end
    end
  end

  private

    attr_reader :user, :countries_to_visit

    def visit_country! country
      return false if visited?(country)
      UserCountry.create country: country, user: user
    end

    def visited? country
      user.countries.include? country
    end

    def collect_currency! currency
      return false if collected?(currency)
      UserCurrency.create currency: currency, user: user
    end

    def collected? currency
      user.currencies.include? currency
    end
end
