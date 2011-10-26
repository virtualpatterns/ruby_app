Feature: Month Calendar Test Page

  @broken
  Scenario: Select a date
    Given I go to the test pages
    Then I should see "Monthly Calendar Test Page"
    When I click "Monthly Calendar Test Page"
    Then I should see "Change the month displayed to January 2000"
    When I click "January 2000"
    And I click "19"
    Then I should see "19/01/2000"
    When I click "Close"
    And I click "back"
    Then I quit