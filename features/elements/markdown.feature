Feature: A block of markdown

  Scenario: Rendering a block of markdown and process its events
    Given I go to the test pages
    When I click "MarkdownTestPage"
    Then I should see "Click here"
    When I click "here"
    Then I should see "This is the other page"
    Then I quit
