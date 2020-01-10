import React, { Component } from 'react'
import Rails from '@rails/ujs'
import CurrenciesChart from './CurrenciesChart'
import { map, filter } from 'lodash'
import { withRouter } from 'react-router-dom'
import { flag } from 'country-emoji'

class Dashboard extends Component {
  state = {
    currencies: {},
    collected_currencies: [],
    visited_countries: [],
    countries_to_visit: []
  }

  constructor(props) {
    super(props)

    this.fetchDashboardInfo = this.fetchDashboardInfo.bind(this)
    this.saveDashboardState = this.saveDashboardState.bind(this)
    this.renderCurrencies = this.renderCurrencies.bind(this)
    this.handleCheckboxToggle = this.handleCheckboxToggle.bind(this)
    this.handleDashboardError = this.handleDashboardError.bind(this)
    this.handleVisitCall = this.handleVisitCall.bind(this)
    this.renderVisitedCountries = this.renderVisitedCountries.bind(this)
    this.renderCollectedCurrencies = this.renderCollectedCurrencies.bind(this)
  }

  componentDidMount() {
    this.fetchDashboardInfo()
  }

  fetchDashboardInfo() {
    Rails.ajax({
      type: "GET",
      url: "/dashboard",
      data: `auth_token=${this.props.authToken}`,
      dataType: "json",
      success: this.saveDashboardState,
      error: this.handleDashboardError
    })
  }

  handleCheckboxToggle() {
    const checkboxes = document.getElementsByClassName("visit-checkbox")
    const checked_items = filter(checkboxes, (checkbox) => (checkbox.checked))

    this.setState({ countries_to_visit: map(checked_items, (checkbox) => (checkbox.value)) })
  }

  handleDashboardError() {
    this.props.history.push("/sign_in")
  }

  handleVisitCall() {
    const countries_param = map(this.state.countries_to_visit, (code) =>
        (`country_codes[]=${code}`)
      ).join('&')

    Rails.ajax({
      type: "POST",
      url: "/countries/visit",
      data: `${countries_param}&auth_token=${this.props.authToken}`,
      dataType: "json",
      success: this.fetchDashboardInfo
    })
  }

  saveDashboardState(data) {
    this.setState({
      currencies: data.currencies,
      collected_currencies: data.collected_currencies,
      visited_countries: data.visited_countries,
      countries_to_visit: [],
      chart_labels: map(data.collected_currencies, (currency) => (currency.collected_at)),
      chart_data: map(data.collected_currencies, (currency) => (currency.currencies_collected))
    })
  }

  renderVisitedCountries() {
    return(
      map(this.state.visited_countries, (country, index) => (
        <li key={ index }>
          <span>{flag(country.code)}</span>{country.name}
        </li>
      ))
    )
  }

  renderCountries(currency) {
    return(
      map(currency.countries, (country, index) => (
        <li key={ country.code } className="country-item">
          <div>
            <input
              type="checkbox"
              className="form-check-input visit-checkbox"
              value={ country.code }
              // checked={ country.visited }
              onChange={ this.handleCheckboxToggle }
            />
            <span>{flag(country.code)}</span>{country.name}
          </div>
        </li>
      ))
    )
  }

  renderCurrencies() {
    return(
      map(this.state.currencies, (currency, index) => (
        <li key={ currency.code } className="currency-item">
          <div>{currency.name} ({currency.code})</div>
          <ul>{this.renderCountries(currency)}</ul>
        </li>
      ))
    )
  }

  renderCollectedCurrencies() {
    return(
      map(this.state.collected_currencies, (currency, index) => (
        <li key={ currency.code }>
          <div>{currency.name} ({currency.code})</div>
        </li>
      ))
    )
  }

  render() {
    return (
      <div>
        <div class="row justify-content-lg-center">
          <div class="col col-lg-4">
            <h3>Available currencies:</h3>
            <ul className="currencies-list">
              { this.renderCurrencies() }
            </ul>
          </div>
          <div class="col col-lg-2">
            <button
              className='btn btn-primary visit-btn'
              type='button'
              onClick={ this.handleVisitCall }
            >
              Visit
            </button>
          </div>
          <div class="col col-lg-4">
            <h3>Visited countries:</h3>
            <ul className="visited-list">
              { this.renderVisitedCountries() }
            </ul>
            <h3>Collected currencies:</h3>
            <ul className="collected-currencies-list">
              { this.renderCollectedCurrencies() }
            </ul>
          </div>
        </div>

        <div class="row justify-content-lg-center">
          <div class="col col-lg-6">
            <CurrenciesChart data={this.state.chart_data} labels={this.state.chart_labels} />
          </div>
        </div>
      </div>
    )
  }
}

export default withRouter(Dashboard)
