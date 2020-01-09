import React, { Component } from 'react'
import Rails from '@rails/ujs'
import { withRouter } from 'react-router-dom'

class SignInForm extends Component {
  state = {
    username: '',
    password: ''
  }

  constructor(props) {
    super(props)
    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleUsernameChange = this.handleUsernameChange.bind(this)
    this.handlePasswordChange = this.handlePasswordChange.bind(this)
    this.handleAuthErrors = this.handleAuthErrors.bind(this)
    this.redirectToRoot = this.redirectToRoot.bind(this)
  }

  handleFormSubmit(event) {
    const { username, password } = this.state

    Rails.ajax({
      type: "POST",
      url: "/sessions",
      data: `username=${username}&password=${password}`,
      dataType: "json",
      success: this.redirectToRoot,
      error: this.handleAuthErrors
    })

    event.preventDefault()
  }

  handleUsernameChange(event) {
    this.setState({ username: event.target.value })
  }

  handlePasswordChange(event) {
    this.setState({ password: event.target.value })
  }

  handleAuthErrors(data) {
    console.log(data)
  }

  redirectToRoot(data) {
    this.props.setAuthToken(data.auth_token)
    this.props.history.push("/")
  }

  render() {
    const { username, password } = this.state

    return (
      <form className="form sign-in-form" onSubmit={ this.handleFormSubmit }>
        <label>
          Username:
          <input
            type="text"
            name="username"
            value={ username }
            onChange={ this.handleUsernameChange }
          />
        </label>

        <label>
          Password:
          <input
            type="password"
            name="password"
            value={ password }
            onChange={ this.handlePasswordChange }
          />
        </label>

        <input className="sign-in-btn" type="submit" value="Sign in" />
      </form>
    )
  }
}

export default withRouter(SignInForm)
