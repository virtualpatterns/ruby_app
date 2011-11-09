Feature: A page

  Scenario: Rendering a page
    Given I go to the test pages
    When I click "TestPage"
    Then I should see "Rendered"
    And I should see "Loaded"
    When I wait 4 seconds
    Then I should see "Triggered"
    Then I quit
