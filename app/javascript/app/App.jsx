import React, { Component } from 'react'
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom'
import Dashboard from './pages/Dashboard'
import Error from './pages/Error'
import SignInForm from './pages/SignInForm'

class App extends Component {
  constructor(props) {
    super(props)

    this.setAuthToken = this.setAuthToken.bind(this)
    this.getAuthToken = this.getAuthToken.bind(this)
  }

  setAuthToken(token) {
    localStorage.setItem('auth_token', token)
  }

  userAuthenticated() {
    return this.getAuthToken()
  }

  getAuthToken() {
    return localStorage.getItem('auth_token')
  }

  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route path="/sign_in">
            <SignInForm setAuthToken={this.setAuthToken} />
          </Route>
          <Route
            path="/"
            exact
            render={() => this.userAuthenticated() ?
              <Dashboard authToken={this.getAuthToken()} /> :
              <Redirect to="/sign_in" />
            }
          />
          <Route component={Error} />
        </Switch>
      </BrowserRouter>
    )
  }
}

export default App
