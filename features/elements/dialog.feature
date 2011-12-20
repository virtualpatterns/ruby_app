Feature: Dialog Test Page

  Scenario: Show a confirmation dialog
    Given I go to the test pages
    When I click "DialogTestPage"
    And I click "ConfirmationDialog"
    Then I should see "Confirmation Dialog"
    And I should see "Are you sure?"
    When I click "Yes"
    Then I should not see "Confirmation Dialog"
    And I should not see "Are you sure?"
    And I should see "You clicked"
    And I should see "true"
    Then I click "Close"
    Then I quit

  Scenario: Show an exception dialog
    Given I go to the test pages
    When I click "DialogTestPage"
    And I click "ExceptionDialog"
    Then I should see "RuntimeError"
    And I should see "Exception dialog"
    When I click "Close"
    Then I should not see "RuntimeError"
    And I should not see "Exception dialog"
    Then I quit

  Scenario: Show a message dialog
    Given I go to the test pages
    When I click "DialogTestPage"
    And I click "MessageDialog"
    Then I should see "Message Dialog"
    And I should see "This is a Message Dialog"
    When I click "Close"
    Then I should not see "Message Dialog"
    And I should not see "This is a Message Dialog"
    Then I quit

  Scenario: Show a calendar month dialog
    Given I go to the test pages
    When I click "DialogTestPage"
    And I click "MonthDialog"
    Then I should see "Wed"
    When I click "15"
    Then I should not see "Wed"
    And I should see "You clicked"
    And I should see "15/"
    When I click "Close"
    Then I should not see "You clicked"
    And I should not see "15/"
    And I should see "-15"
    Then I quit
