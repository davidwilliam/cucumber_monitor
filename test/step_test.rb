require 'test_helper'

class StepTest < ActiveSupport::TestCase

  test "step should return its siblings" do
  	step = @feature_two.scenarios.first.steps.first

    siblings = [
    	           'Given I am at the google page',
    	           'When I search for "New York Times"',
    	           'Then I should se "The New York Times - Breaking News, World News & Multimedia"',
               ]
    assert_equal siblings, step.siblings_and_self.map(&:description)
  end

  test "step should get the previous step" do
  	last_step = @feature_two.scenarios.first.steps.last
  	previous_step = 'When I search for "New York Times"'
    assert_equal previous_step, last_step.previous.description
  end

  test "step should get the next step" do
  	first_step = @feature_two.scenarios.first.steps.first
  	next_step = 'When I search for "New York Times"'
    assert_equal next_step, first_step.next.description
  end

  test  "step should return empty array when there is no next or previous step" do
  	first_step = @feature_two.scenarios.first.steps.first
  	last_step = @feature_two.scenarios.first.steps.last
  	
    assert_equal [], first_step.previous
    assert_equal [], last_step.next
  end

  test "step should return the code of step definition" do
    feature = @cucumber.features.where(name: 'google_search')
    first_step = feature.scenarios.first.steps.first

    expected_definition_lines = ['Given /^I am at the google page$/ do', 'visit "http://www.google.com', 'end']

    # expected_first_step_definition = 'google_search_step.rb:1'

    assert_equal expected_definition_lines, first_step.definition
  end

end
