require 'test_helper'

class CucumberMonitorTest < ActiveSupport::TestCase

	def setup
		@cucumber = CucumberMonitor.new
		@feature_one = @cucumber.features.first
		@feature_two = @cucumber.features.last
	end

  test "should return all features" do
    assert_equal 2, @cucumber.features.size

    features = ['administration.feature','change_my_data.feature']
    assert_equal features, @cucumber.features.map(&:file)
  end

  test "features should have the attributes name, file and description" do
  	assert_equal 'administration', @feature_one.name
  	assert_equal 'administration.feature', @feature_one.file
  	assert_equal 'Access the system as an administrator', @feature_one.description
  end

  test "feature should return its scenarios" do
  	assert_equal 2, @feature_one.scenarios.size
  	assert_equal 'Access with valid data', @feature_one.scenarios[0].name
  	assert_equal 'Access with invalid data', @feature_one.scenarios[1].name
  end

  test "feature should return its contexts when applicable" do
  	assert_equal 1, @feature_two.contexts.size
  end

  test "scenario should return its steps" do
  	assert_equal 3, @feature_one.scenarios.first.steps.size

  	step_1 = 'Given that there is an administrator with the email "admin@domain.com" and password "123456"'
  	step_2 = 'When I try to access the admin dashboard with the email "admin@domain.com" and senha "123456"'
  	step_3 = 'Then I should be at admin dashboard page'

  	assert_equal step_1, @feature_one.scenarios.first.steps[0].description
  	assert_equal step_2, @feature_one.scenarios.first.steps[1].description
  	assert_equal step_3, @feature_one.scenarios.first.steps[2].description
  end

  test "context should return its steps" do
    assert_equal 1, @feature_two.contexts.first.steps.size

    step_1 = 'Given my name is Peter and I have an account in the system'

    assert_equal step_1, @feature_two.contexts.first.steps[0].description
  end

  test "should find features by searching" do
  	assert_equal 2, @cucumber.features.where(name: 'a').size
  	features = ['administration.feature','change_my_data.feature']
  	assert_equal features, @cucumber.features.where(name: 'a').map(&:file)

  	assert_equal 'administration.feature', @cucumber.features.where(name: 'admin').file
  	assert_equal 'change_my_data.feature', @cucumber.features.where(name: 'change').file
  end

  test 'should find steps within scenario by searching' do
  	assert_equal 3, @feature_one.scenarios.first.steps.where(description: 'a').size
    step = 'Then I should be at admin dashboard page'
    assert_equal step, @feature_one.scenarios.first.steps.where(description: 'dashboard page').description
  end

  test 'should find all steps that matches with a given term' do
  	assert_equal 4, @cucumber.search("email").size

  	term = 'I should see'

  	steps = [
  		        'Then I should see "Invalid username/password"',
  		        'Then I should see my personal information',
  		        'Then I should see "Personal data successfully changed"',
  		        'And I should see "Petter Summers"',
  		        'I should see the following table:'
  	        ]

  	assert_equal steps, @cucumber.search(term).map(&:description)
  end

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
