@javascript
Feature: User sign in
  I want to see sign in form if unauthorized.
  When authorized, I should be redirected to the dashboard.

  Background:
    Given the user exists

  Scenario: Redirect user if unauthorized
    When I go to the dashboard page
    Then I should be redirected to sign in page

  Scenario: Authorize user
    When I go to sign in page
    Then I should see the authorization form
    When I fill in incorrect credentials
    And I submit the form
    Then I should see the alert message
    When I fill in correct credentials
    And I submit the form
    Then I should be redirected to the dashboard page
