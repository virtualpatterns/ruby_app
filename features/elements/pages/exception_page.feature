Feature: Exception page

  Scenario: View the exception page
    Given I go to the test pages
    When I click "ExceptionTestPage"
    Then I should see "RuntimeError"
    And I should see "Exception page"
    Given I am viewing "/quit"
    Then I should see "Click here to go to the test pages"

