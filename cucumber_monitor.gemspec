$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cucumber_monitor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'cucumber_monitor'
  s.version = CucumberMonitor::VERSION
  s.authors = ["David William"]
  s.description = 'Visualization and manipulation of cucumber features.'
  s.summary = "Puts your features in a highlighted position. Adds a dashboard for viewing, searching and better identification of yours scenarios and steps."
  s.email = 'david@webhall.com.br'
  s.homepage = "http://www.webhall.com.br"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency 'cucumber-rails', '>= 1.1.1'
end
