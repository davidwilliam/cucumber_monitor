require 'test_helper'

class FeatureFileTest < ActiveSupport::TestCase

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

end
