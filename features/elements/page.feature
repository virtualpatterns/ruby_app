Feature: A page

  Scenario: Rendering a page
    Given I go to the test pages
    When I click "_TestPage"
    Then I should see "Rendered"
    And I should see "Loaded"
    When I wait 4 seconds
    Then I should see "Triggered"
    Then I quit

  Scenario: Saving and retrieving a cookie
    Given I go to the test pages
    When I click "_TestPage"
    Then I should see "Rendered"
    When I fill in the "Enter a new cookie value" field with "value" and I press enter
    Then I should see "The cookie value is 'value'."
    Then I click "Close"
    Then I quit
    When I go to the test pages
    And I click "_TestPage"
    Then I should see "The cookie value is 'value'."
    Then I quit

  Scenario Outline: Loading the home page
    Given I am viewing "/"
    And I should see "Loaded"

    Scenarios: Count
      | count |
      | X     |
      | X     |
