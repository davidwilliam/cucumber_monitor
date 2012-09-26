# encoding: UTF-8

require "cucumber_monitor/engine"

require 'cucumber_monitor/base'
require 'cucumber_monitor/feature_file'
require 'cucumber_monitor/scenario'
require 'cucumber_monitor/context'
require 'cucumber_monitor/step'
require 'cucumber_monitor/string'
require 'cucumber_monitor/array'
require 'cucumber_monitor/feature_runner'

module CucumberMonitor

  def self.new
    CucumberMonitor::Base.new
  end

  def self.path
    (Rails.root if defined?(Rails)) || "#{CucumberMonitor::Engine.root}#{app_test_dir}"
  end

  def self.app_test_dir
    "/test/dummy" if Rails.env == 'test'
  end

  def self.cucumber_rails_ready?
    files = [
              "#{path}/script/cucumber",
              "#{path}/features",
              "#{path}/lib/tasks/cucumber.rake"
            ]
    files.all? { |f| File.exist?(f) } && YAML.load_file("#{path}/config/database.yml").has_key?("cucumber")
  end

end
