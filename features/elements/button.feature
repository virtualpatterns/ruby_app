Feature: A button

  Scenario: Rendering a button and process its event
    Given I go to the test pages
    When I click "ButtonTestPage"
    Then I should see "Click"
    When I click "Click"
    Then I should see "This is the other page"
    Then I quit
