Feature: List element

  Scenario: Render a list element and process its event
    Given I go to the test pages
    When I click "ListTestPage"
    Then I should see "Item 03"
    When I click "Item 03"
    Then I should see "You clicked 'Item 03'."
    Then I click "Close"
    Then I quit

  Scenario: Render a select list element and process its event
    Given I go to the test pages
    When I click "ListTestPage"
    Then I should see "Item 13"
    When I click "Item 13"
    Then I should see "You clicked 'Item 13'."
    Then I click "Close"
    Then I quit
