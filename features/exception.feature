Feature: View a variety of exception handling pages

  @broken
  Scenario: View the exception test page
    Given I go to the test pages
    When I click "Exception Test Page"
    Then I should see "Displayed 1 times"
    When I refresh the page
    Then I should see "Displayed 2 times"
    When I refresh the page
    Then I should see "Displayed 3 times"
    When I refresh the page
    Then I should see "Displayed 4 times"
    When I refresh the page
    Then I should see "Displayed 5 times"
    When I refresh the page
    Then I should see "RuntimeError"
    And I should see "Displayed more than 5 times"
    When I refresh the page
    And I refresh the page
    Then I should see "Displayed 2 times"
    And I quit

  @broken
  Scenario: View the update exception test page
    Given I go to the test pages
    When I click "Exception Test Page"
    Then I should see "Updated 1 times"
    When I click "Update"
    Then I should see "Updated 2 times"
    When I click "Update"
    Then I should see "Updated 3 times"
    When I click "Update"
    Then I should see "Updated 4 times"
    When I click "Update"
    Then I should see "Updated 5 times"
    When I click "Update"
    Then I should see "RuntimeError"
    And I should see "Updated more than 5 times"
    When I refresh the page
    Then I should see "Updated 1 times"
    And I quit

  @broken
  Scenario: View the dialog exception test page
    Given I go to the test pages
    When I click "Exception Test Page"
    Then I should see "Show dialog"
    When I click "Show dialog"
    Then I should see "Dialog exception"
    When I click "Close"
    Then I should not see "Dialog exception"
    And I quit
