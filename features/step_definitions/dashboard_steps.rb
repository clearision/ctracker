Given("the initial data is set up") do
  user = User.create username: 'admin', password: 'password'

  country_1 = Country.create name: 'Ukraine', code: 'ua'
  country_2 = Country.create name: 'Poland', code: 'pl'

  currency_1 = Currency.create name: 'Hryvnia', code: 'UAH'
  currency_2 = Currency.create name: 'Zloty', code: 'PLN'

  country_currency_1 = CountryCurrency.create country: country_1, currency: currency_1
  country_currency_2 = CountryCurrency.create country: country_2, currency: currency_2
end

And("the user is signed in") do
  step("I go to sign in page")
  step("I fill in the credentials")
  step("I submit the form")
end

When("I go to the dashboard page") do
  visit '/'
end

Then("I should see available currencies list with countries") do
  expect(page).to have_css('.currencies-list')
  expect(page.find_all('.currency-item').count).to eq 2
  expect(page.find_all('.country-item').count).to eq 2
end

And("I check Ukraine from countries list") do
  page.find_all('.visit-checkbox[value=ua]').first.click
end

Then("I click the Visit button") do
  page.find('.visit-btn').click
end

Then("I should see the visited countries list updated") do
  expect(page.find_all('.visited-list li').count).to eq 1
  expect(page.find_all('.visited-list li').first.text).to include 'Ukraine'
end

And("I should see the collected currencies list updated") do
  expect(page.find_all('.collected-currencies-list li').count).to eq 1
  expect(page.find_all('.collected-currencies-list li').first.text).to eq 'Hryvnia (UAH)'
end
