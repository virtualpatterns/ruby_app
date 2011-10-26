Feature: Interact with the breadcrumbs

  @broken
  Scenario: View the breadcrumbs test page
    Given I go to the test pages
    When I click "Breadcrumbs Test Page"
    Then I should see "Add"
    When I click "Add"
    And I click "Breadcrumbs Test Page"
    Then I should see "Add"
    And I quit
