require 'test_helper'

class StepTest < ActiveSupport::TestCase

  test "step should return its siblings" do
  	step = @feature_two.scenarios.first.steps.first

    siblings = [
    	           'Given I am at the google page',
    	           'When I search for "New York Times"',
    	           'Then I should see "The New York Times - Breaking News, World News & Multimedia"',
                 'And I should see 1 occurrence of "New York Times Company"'
               ]
    assert_equal siblings, step.siblings_and_self.map(&:description)
  end

  test "step should get the previous step" do
  	last_step = @feature_two.scenarios.first.steps.last
  	previous_step = 'Then I should see "The New York Times - Breaking News, World News & Multimedia"'
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

    expected_definition_lines = ['Given /^I am at the google page$/ do', 'visit "http://www.google.com"', 'end']
    expected_definition_location = 'google_search_step.rb:1'


    assert_equal expected_definition_lines, first_step.definition.content
    assert_equal expected_definition_location, first_step.definition.location
  end

  test "step should tell when a step was not implemented yet" do
    feature = @cucumber.features.where(name: 'change_my_data')
    step = feature.scenarios.first.steps.first

    assert_nil step.definition
    assert !step.implemented?
  end

  test "step should return its params when applicable" do
    feature = @cucumber.features.where(name: 'google_search')
    step = feature.scenarios.first.steps.last

    assert_equal 2, step.params.size
  end

  test "step should return description without keyword" do
    feature = @cucumber.features.where(name: 'google_search')
    description_without_keyword_1 = 'I am at the google page'
    description_without_keyword_2 = 'I search for "New York Times"'
    description_without_keyword_3 = 'I should see "The New York Times - Breaking News, World News & Multimedia"'
    description_without_keyword_4 = 'I should see 1 occurrence of "New York Times Company"'

    assert_equal description_without_keyword_1, feature.scenarios.first.steps[0].description_without_keyword
    assert_equal description_without_keyword_2, feature.scenarios.first.steps[1].description_without_keyword
    assert_equal description_without_keyword_3, feature.scenarios.first.steps[2].description_without_keyword
    assert_equal description_without_keyword_4, feature.scenarios.first.steps[3].description_without_keyword
  end

end
