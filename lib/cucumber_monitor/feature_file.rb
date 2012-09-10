# encoding: UTF-8

module CucumberMonitor

  class FeatureFile

    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def name
      file[0..-9]
    end

    def lines
      f = open(CucumberMonitor::Base.features_path + '/' + file)
      file_lines = f.readlines
      f.close
      file_lines
    end

    def description
      desc = ""
      lines.each do |line|
        if line.include?(I18n.t("feature"))
          desc = line.clean
        end
      end
      desc
    end

    def scenarios
      scen = []
      lines.each do |line|
        if line.include?(I18n.t("scenario"))
          scen << Scenario.new(line.clean,self.class.new(file))
        end
      end
      scen
    end

    def scenarios_names
      scenarios.map(&:name)
    end

    def contexts
      cont = []
      lines.each do |line|
        if line.include?(I18n.t("background"))
          cont << Context.new(line.clean,self.class.new(file))
        end
      end
      cont
    end

  end

end