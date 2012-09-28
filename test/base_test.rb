require 'test_helper'

class BaseTest < ActiveSupport::TestCase

  test "should return all features" do
    assert_equal 3, @cucumber.features.size

    features = ['administration.feature','change_my_data.feature','google_search.feature']
    assert_equal features, @cucumber.features.map(&:file)
  end

  test "should find features by searching" do
  	assert_equal 3, @cucumber.features.where(name: 'a').size
  	features = ['administration.feature','change_my_data.feature','google_search.feature']
  	assert_equal features, @cucumber.features.where(name: 'a').map(&:file)

  	assert_equal 'administration.feature', @cucumber.features.where(name: 'admin').file
    assert_equal 'change_my_data.feature', @cucumber.features.where(name: 'change').file
  	assert_equal 'google_search.feature', @cucumber.features.where(name: 'search').file
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

end
