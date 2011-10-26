Feature: Default Page

  Scenario: View the default page
    Given I am viewing "/en"
    Then I should see "This is the default start page"
