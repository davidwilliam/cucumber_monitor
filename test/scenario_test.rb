require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase

  test "scenario should return its steps" do
  	assert_equal 3, @feature_one.scenarios.first.steps.size

  	step_1 = 'Given that there is an administrator with the email "admin@domain.com" and password "123456"'
  	step_2 = 'When I try to access the admin dashboard with the email "admin@domain.com" and senha "123456"'
  	step_3 = 'Then I should be at admin dashboard page'

  	assert_equal step_1, @feature_one.scenarios.first.steps[0].description
  	assert_equal step_2, @feature_one.scenarios.first.steps[1].description
  	assert_equal step_3, @feature_one.scenarios.first.steps[2].description
  end

  test 'should find steps within scenario by searching' do
  	assert_equal 3, @feature_one.scenarios.first.steps.where(description: 'a').size
    step = 'Then I should be at admin dashboard page'
    assert_equal step, @feature_one.scenarios.first.steps.where(description: 'dashboard page').description
  end

end
