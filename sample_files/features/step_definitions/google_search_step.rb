Given /^I am at the google page$/ do
  visit "http://www.google.com"
end

When /^I search for "(.*?)"$/ do |term|
  fill_in 'gbqfq', with: term
end

Then /^I should see "(.*?)"$/ do |string|
  page.has_content?(string)
end