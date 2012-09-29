Given /^I am at the google page$/ do
  visit "http://www.google.com"
end

When /^I search for "(.*?)"$/ do |term|
  fill_in 'gbqfq', with: term
  click_on 'gbqfba'
end

Then /^I should see "(.*?)"$/ do |string|
  assert page.has_content?(string)
end

Then /^I should see (\d+) occurrence of "(.*?)"$/ do |number, string|
  assert_equal number.to_i, page.all('a', text: string).count
end