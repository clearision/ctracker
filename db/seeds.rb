### Sample user

User.create! username: 'mrsmart', password: 'password'
User.create! username: 'hismate', password: 'mellon'


### Countries

countries_list = [
  [ "USA", 'us' ],
  [ "Canada", 'ca' ],
  [ "Germany", 'de' ],
  [ "France", 'fr' ],
  [ "United Kingdom", 'gb' ],
  [ "Ukraine", 'ua' ],
  [ "Argentina", 'ar' ]
]

countries_list.each do |name, code|
  Country.create! name: name, code: code
end


### Currencies

currencies_list = [
  [ "US Dollar", "USD" ],
  [ "Canadian Dollar", "CAD" ],
  [ "Euro", "EUR" ],
  [ "British Pound", 'GBP' ],
  [ "Hryvnia", "UAH" ],
  [ "Peso", "ARS" ]
]

currencies_list.each do |name, code|
  Currency.create! name: name, code: code
end


### Currency presence in country (some currencies are available in several countries)

country_currencies_list = [
  [ "USD", 'us' ],
  [ "EUR", 'de' ],
  [ "EUR", 'fr' ],
  [ "GBP", 'gb' ],
  [ "UAH", 'ua' ],
  [ "ARS", 'ar' ],
  [ "CAD", 'ca' ]
]

country_currencies_list.each do |currency_code, country_code|
  CountryCurrency.create! \
    currency: Currency.find_by_code(currency_code),
    country: Country.find_by_code(country_code)
end
