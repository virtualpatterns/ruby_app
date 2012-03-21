Feature: Input elements

  Scenario: Render a simple input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "Input"
    And I fill in the "Input" field with "value" and I change focus
    Then I should see "You input 'value'"
    When I click "Close"
    And I fill in the "Input" field with "" and I change focus
    Then I should see "You input '(nil)'"
    Then I click "Close"
    Then I quit

  Scenario: Render a duration input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "DurationInput"
    When I fill in the "DurationInput" field with "2h 3m" and I change focus
    Then I should see "You input '7,380'"
    When I click "Close"
    Then the "DurationInput" field should contain "2 hrs 3 mins"
    Then I quit

  Scenario: Render a multiline input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "MultilineInput"
    And I fill in the "MultilineInput" field with "value" and I change focus
    Then I should see "You input 'value'"
    When I click "Close"
    And I fill in the "MultilineInput" field with "" and I change focus
    Then I should see "You input '(nil)'"
    Then I click "Close"
    Then I quit

  Scenario: Render a email input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "EmailInput"
    And I fill in the "EmailInput" field with "value" and I change focus
    Then I should see "You input 'value'"
    When I click "Close"
    And I fill in the "EmailInput" field with "" and I change focus
    Then I should see "You input '(nil)'"
    Then I click "Close"
    Then I quit

  Scenario: Render a toggle input element and process its event
    Given I go to the test pages
    When I click "InputTestPage"
    Then I should see "ToggleInput"
    And the "ToggleInput" field should be unchecked
    When I check the "ToggleInput" field
    Then I should see "You input 'true'"
    When I click "Close"
    And I uncheck the "ToggleInput" field
    Then I should see "You input 'false'"
    Then I click "Close"
    Then I quit
