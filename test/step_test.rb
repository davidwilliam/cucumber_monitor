require 'test_helper'

class StepTest < ActiveSupport::TestCase

  test "step should return its siblings" do
  	step = @feature_one.scenarios.first.steps.first

    siblings = [
    	           'Given that there is an administrator with the email "admin@domain.com" and password "123456"',
    	           'When I try to access the admin dashboard with the email "admin@domain.com" and senha "123456"',
    	           'Then I should be at admin dashboard page',
               ]
    assert_equal siblings, step.siblings_and_self.map(&:description)
  end

  test "step should get the previous step" do
  	last_step = @feature_one.scenarios.first.steps.last
  	previous_step = 'When I try to access the admin dashboard with the email "admin@domain.com" and senha "123456"'
    assert_equal previous_step, last_step.previous.description
  end

  test "step should get the next step" do
  	first_step = @feature_one.scenarios.first.steps.first
  	next_step = 'When I try to access the admin dashboard with the email "admin@domain.com" and senha "123456"'
    assert_equal next_step, first_step.next.description
  end

  test  "step should return empty array when there is no next or previous step" do
  	first_step = @feature_one.scenarios.first.steps.first
  	last_step = @feature_one.scenarios.first.steps.last
  	
    assert_equal [], first_step.previous
    assert_equal [], last_step.next
  end

end
