require "application_system_test_case"

class UserCurrenciesTest < ApplicationSystemTestCase
  setup do
    @user_currency = user_currencies(:one)
  end

  test "visiting the index" do
    visit user_currencies_url
    assert_selector "h1", text: "User Currencies"
  end

  test "creating a User currency" do
    visit user_currencies_url
    click_on "New User Currency"

    fill_in "Currency", with: @user_currency.currency_id
    fill_in "User", with: @user_currency.user_id
    click_on "Create User currency"

    assert_text "User currency was successfully created"
    click_on "Back"
  end

  test "updating a User currency" do
    visit user_currencies_url
    click_on "Edit", match: :first

    fill_in "Currency", with: @user_currency.currency_id
    fill_in "User", with: @user_currency.user_id
    click_on "Update User currency"

    assert_text "User currency was successfully updated"
    click_on "Back"
  end

  test "destroying a User currency" do
    visit user_currencies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User currency was successfully destroyed"
  end
end
