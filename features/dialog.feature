Feature: Dialog Test Page

  @broken
  Scenario: Show a busy dialog
    Given I go to the test pages
    Then I should see "DialogTestPage"
    When I click "DialogTestPage"
    Then I should see "BusyDialog"
    When I click "BusyDialog"
    Then I should see "Busy dialog"
    When I wait 30 seconds
    Then I should not see "Busy dialog"
    Then I quit

  Scenario: Show an exception dialog
    Given I go to the test pages
    Then I should see "DialogTestPage"
    When I click "DialogTestPage"
    Then I should see "ExceptionDialog"
    When I click "ExceptionDialog"
    Then I should see "RuntimeError"
    And I should see "Exception dialog"
    When I click "Close"
    Then I should not see "RuntimeError"
    And I should not see "Exception dialog"
    Then I quit

  Scenario: Show a message dialog
    Given I go to the test pages
    Then I should see "DialogTestPage"
    When I click "DialogTestPage"
    Then I should see "MessageDialog"
    When I click "MessageDialog"
    Then I should see "Message Dialog"
    And I should see "This is a Message Dialog"
    When I click "Close"
    Then I should not see "Message Dialog"
    And I should not see "This is a Message Dialog"
    Then I quit

  Scenario: Show a calendar month dialog
    Given I go to the test pages
    Then I should see "DialogTestPage"
    When I click "DialogTestPage"
    Then I should see "MonthDialog"
    When I click "MonthDialog"
    Then I should see "Wed"
    When I click "15"
    Then I should not see "Wed"
    And I should see "You selected"
    And I should see "15/"
    When I click "Close"
    Then I should not see "You selected"
    And I should not see "15/"
    And I should see "-15"
    Then I quit
