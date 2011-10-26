Feature: List Test Page

  Scenario: Select an item from a list
    Given I go to the test pages
    Then I should see "ListTestPage"
    When I click "ListTestPage"
    Then I should see "Item 06"
    When I click "Item 06"
    And I should see "You selected the item 'Item 06'"
    When I click "Close"
    And I should not see "You selected the item 'Item 06'"
    Then I quit
