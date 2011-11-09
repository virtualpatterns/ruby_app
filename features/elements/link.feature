Feature: A link

  Scenario: Rendering a link and process its event
    Given I go to the test pages
    When I click "LinkTestPage"
    Then I should see "Click"
    When I click "Click"
    Then I should see "This is the other page"
    Then I quit
