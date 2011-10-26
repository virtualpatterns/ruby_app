Feature: View a variety of input elements

  @broken
  Scenario: View the text input element
    Given I go to the test pages
    When I click "Input Test Page"
    Then I should see "Enter some text below"
    And I fill in "Text:" with "Some value" and I press enter
    Then I should see "You entered ..."
    And I should see "Some value"
    When I click "Close"
    Then I should not see "You entered ..."
    And I quit
