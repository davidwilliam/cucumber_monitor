require 'test_helper'

class ContextTest < ActiveSupport::TestCase

  test "context should return its steps" do
    assert_equal 1, @feature_two.contexts.first.steps.size

    step_1 = 'Given my name is Peter and I have an account in the system'

    assert_equal step_1, @feature_two.contexts.first.steps[0].description
  end

end
