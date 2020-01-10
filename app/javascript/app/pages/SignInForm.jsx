import React, { Component } from 'react'
import Rails from '@rails/ujs'
import { withRouter } from 'react-router-dom'

class SignInForm extends Component {
  state = {
    username: '',
    password: '',
    showAlert: false
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
    this.setState({ showAlert: true })
  }

  redirectToRoot(data) {
    this.setState({ showAlert: false })
    this.props.setAuthToken(data.auth_token)
    this.props.history.push("/")
  }

  render() {
    const { username, password } = this.state

    return (
      <div className="row justify-content-lg-center">
        <div className="col col-lg-4">
          <form className="sign-in-form" onSubmit={ this.handleFormSubmit }>
            <div className="form-group">
              <label>Username:</label>
              <input
                type="text"
                name="username"
                value={ username }
                onChange={ this.handleUsernameChange }
                className="form-control"
              />
            </div>
            <div className="form-group">
              <label>Password:</label>
              <input
                type="password"
                name="password"
                value={ password }
                onChange={ this.handlePasswordChange }
                className="form-control"
              />
            </div>
            { this.state.showAlert ?
                <div className="sign-in-error alert alert-danger">
                  Incorrect username or password!
                </div>
                : null
            }
            <input className="btn btn-primary sign-in-btn" type="submit" value="Sign in" />
          </form>
        </div>
      </div>
    )
  }
}

export default withRouter(SignInForm)
