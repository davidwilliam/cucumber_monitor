class Test::Unit::TestCase
  def setup
    @cucumber = CucumberMonitor.new
    @feature_one = @cucumber.features.first
    @feature_two = @cucumber.features.last
  end
end
