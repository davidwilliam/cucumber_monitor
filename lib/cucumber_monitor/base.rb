# encoding: UTF-8

module CucumberMonitor
  class Base

    def self.features_path
      Dir.pwd.to_s + '/features'
    end

    def self.cucumber_output_file
      Dir.pwd.to_s + '/tmp/cucumber.out'
    end

    def locate
      "Printing: #{I18n.t("feature")}"
    end

    def files
      collection = []
      dir_entries = Dir.entries(self.class.features_path)
      search_and_include_features(dir_entries)
    end

    def search_and_include_features(dir_entries, collection=[])
      dir_entries.each do |entrie|
        if entrie.include?('.feature')
          collection << entrie
        end
      end
      collection
    end

    def features
      collection = []
      files.each do |file|
        collection << CucumberMonitor::FeatureFile.new(file)  
      end
      collection
    end

    def search(criteria)
      results = []
      features.each do |feature|
        feature.scenarios.each do |scenario|
          scenario.steps.each do |step|
            results << step if step.description.include?(criteria)
          end
        end
      end
      results
    end

  end
end