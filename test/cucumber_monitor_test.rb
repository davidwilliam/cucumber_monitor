require 'test_helper'

class CucumberMonitorTest < ActiveSupport::TestCase

  test "should tell cucumber-rails is ready" do
    uninstall_cucumber_rails
    Dir.chdir("#{@path}")
    `rails generate cucumber:install`
    Dir.chdir("..")
    assert CucumberMonitor.cucumber_rails_ready?
  end
end
