Given /^I go to the test pages$/ do
  steps %Q{
    Given I am viewing "/"
    Then I should see "Click here to go to the test pages"
    Then I click "here"
  }
end

Then /^I quit$/ do
  steps %Q{
    Given I am viewing "/quit"
  }
end
