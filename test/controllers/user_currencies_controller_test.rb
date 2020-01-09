require 'test_helper'

class UserCurrenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_currency = user_currencies(:one)
  end

  test "should get index" do
    get user_currencies_url
    assert_response :success
  end

  test "should get new" do
    get new_user_currency_url
    assert_response :success
  end

  test "should create user_currency" do
    assert_difference('UserCurrency.count') do
      post user_currencies_url, params: { user_currency: { currency_id: @user_currency.currency_id, user_id: @user_currency.user_id } }
    end

    assert_redirected_to user_currency_url(UserCurrency.last)
  end

  test "should show user_currency" do
    get user_currency_url(@user_currency)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_currency_url(@user_currency)
    assert_response :success
  end

  test "should update user_currency" do
    patch user_currency_url(@user_currency), params: { user_currency: { currency_id: @user_currency.currency_id, user_id: @user_currency.user_id } }
    assert_redirected_to user_currency_url(@user_currency)
  end

  test "should destroy user_currency" do
    assert_difference('UserCurrency.count', -1) do
      delete user_currency_url(@user_currency)
    end

    assert_redirected_to user_currencies_url
  end
end
