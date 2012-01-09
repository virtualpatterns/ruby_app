Given /^I am viewing "([^"]*)"$/ do |url|
  visit("#{url}?show_event_error=false")
end

When /^I refresh the page$/ do
  visit(current_path)
end

Then /^I should (not )?see "([^"]*)"$/ do |negative, text|
  unless negative
    page.should have_content(text)
  else
    page.should_not have_content(text)
  end
end

When /^I click "([^"]*)"$/ do |text|
  click_on(text)
end

When /^I fill in the "([^"]*)" field with "([^"]*)"( and I change focus)?$/ do |field, value, change_focus|
  fill_in(field, :with => value)
  if change_focus
    find('body').click
  end
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  field_labeled(field).value.should =~ /#{value}/
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I wait (\d+) seconds$/ do |interval|
  sleep(interval.to_f)
end
