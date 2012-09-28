class Test::Unit::TestCase
  def setup
    @cucumber = CucumberMonitor.new
    @feature_one = @cucumber.features.first
    @feature_two = @cucumber.features.last
    @feature_three = @cucumber.features.where(name: 'change_my_data')
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
    FileUtils.cp_r("#{@root}/sample_files/features",@path)
  end
end
