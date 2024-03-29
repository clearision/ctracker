Given("the user exists") do
  User.create username: 'admin', password: 'password'
end

Then("I should be redirected to sign in page") do
  expect(page).to have_current_path('/sign_in')
end

When("I go to sign in page") do
  visit '/sign_in'
end

Then("I should see the authorization form") do
  expect(page).to have_css('form.sign-in-form')
end

When(/^I fill in (correct|incorrect) credentials$/) do |choice|
  page.fill_in 'username', with: choice == 'correct' ? 'admin' : 'stranger'
  page.fill_in 'password', with: 'password'
end

And("I submit the form") do
  page.find('.sign-in-btn').click
end

Then("I should be redirected to the dashboard page") do
  expect(page).to have_current_path('/')
end

Then("I should see the alert message") do
  expect(page).to have_css('.sign-in-error')
end
