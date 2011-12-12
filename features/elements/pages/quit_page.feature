Feature: Quit page

  Scenario: View the quit page
    Given I go to the test pages
    When I click "Settings"
    Then I should see "Quit the session"
    When I am viewing "/quit"
    Then I should see "Click here to go to the test pages"
