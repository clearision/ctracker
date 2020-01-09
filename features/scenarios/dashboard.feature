@javascript
Feature: Dashboard
  I want to see list of available countries to visit and currencies to collect.
  Also I want to be able to collect currency and see my progress on visual chart.

  Background:
    Given the initial data is set up
    And the user is signed in

  Scenario: Show available currencies list
    When I go to the dashboard page
    Then I should see available currencies list with countries

  Scenario: Visit country and collect currency
    When I go to the dashboard page
    And I check Ukraine from countries list
    Then I click the Visit button
    Then I should see the visited countries list updated
    And I should see the collected currencies list updated
