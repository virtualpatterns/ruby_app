Feature: Clicking a link in content

  @broken
  Scenario: Clicking a link in content
    Given I go to the test pages
    When I click "Content Test Page"
    Then I should see "Click this one to go somewhere and this other one to go somewhere else."
    When I click "this one"
    Then I should see "You selected ..."
    And I should see "google"
    When I click "Close"
    And I click "this other one"
    Then I should see "You selected ..."
    And I should see "yahoo"
    When I click "Close"
    And I quit
