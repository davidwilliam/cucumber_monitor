class Test::Unit::TestCase
  def setup
    @cucumber = CucumberMonitor.new
    @feature_one = @cucumber.features.first
    @feature_two = @cucumber.features.last
    @path = CucumberMonitor.path
    @root = CucumberMonitor::Engine.root
    copy_sample_features
  end

  def uninstall_cucumber_rails
    File.delete("#{@path}/script/cucumber") if File.exist?("#{@path}/script/cucumber")
    FileUtils.rm_rf("#{@path}/features") if Dir.exist?("#{@path}/features")
    File.delete("#{@path}/lib/tasks/cucumber.rake") if File.exist?("#{@path}/lib/tasks/cucumber.rake")
    config = YAML.load_file("#{@path}/config/database.yml")
    config.delete("cucumber") if config.has_key?("cucumber")
  end

  def copy_sample_features
    FileUtils.cp("#{@root}/features/administration.feature","#{@path}/features/administration.feature")
    FileUtils.cp("#{@root}/features/change_my_data.feature","#{@path}/features/change_my_data.feature")
  end
end
