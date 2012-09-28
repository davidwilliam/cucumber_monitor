# encoding: UTF-8

module CucumberMonitor
  class Base

    def self.path
      CucumberMonitor.path
    end

    def self.features_path
      "#{path}/features"
    end

    def self.step_definitions_path
      "#{features_path}/step_definitions"
    end

    def self.cucumber_output_file
      "#{path}/tmp/cucumber.out"
    end

    def locate
      "Printing: #{I18n.t("feature")}"
    end

    def files
      collection = []
      dir_entries = Dir.entries(self.class.features_path)
      search_and_include_features(dir_entries)
    end

    def step_definitions_files
      collection = []
      dir_entries = Dir.entries(self.class.step_definitions_path)
      search_and_include_step_definitions(dir_entries)
    end

    def search_and_include_features(dir_entries, collection=[])
      dir_entries.each do |entrie|
        if entrie.include?('.feature')
          collection << entrie
        end
      end
      collection
    end

    def search_and_include_step_definitions(dir_entries, collection=[])
      dir_entries.each do |entrie|
        if entrie.include?('_step.rb')
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

    def step_definitions
      collection = []
      step_definitions_files.each do |file|
        collection << CucumberMonitor::StepDefinitionFile.new(file)  
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

    def search_match(criteria)
      results = []
      step_definitions.each do |step_definition|
        step_definition.definitions.each do |definition|
            matcher = Amatch::Sellers.new(criteria)
            results << {definition: definition, score: matcher.match(definition.description)}
        end
      end
      results.min {|a,b| a[:score] <=> b[:score]}[:definition] if results.any?
    end

  end
end