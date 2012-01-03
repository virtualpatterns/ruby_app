Feature: Input elements

  Scenario: Render a simple input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "Input"
    And I fill in the "Input" field with "value" and I press enter
    Then I should see "You input 'value'."
    When I fill in the "Input" field with "" and I press enter
    Then I should see "You input '(nil)'."
    Then I click "Close"
    Then I quit

  Scenario: Render a duration input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "DurationInput"
    And I fill in the "DurationInput" field with "2h 3m" and I press enter
    Then I should see "You input '7,380'."
    When I click "Close"
    Then the "DurationInput" field should contain "2 hrs 3 mins"
    Then I quit
