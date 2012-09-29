# encoding: UTF-8

module CucumberMonitor

  class StepDefinitionFile

    attr_accessor :file, :path

    def self.keywords
      [I18n.t("given"), I18n.t("when"), I18n.t("then"), I18n.t("and"), I18n.t("but")].collect{|c| c[2..-1]}
    end

    def initialize(file,path)
      @file = file
      @path = path
    end

    def name
      file[0..-9]
    end

    def lines
      f = open(CucumberMonitor::Base.step_definitions_path + '/' + file)
      file_lines = f.readlines
      f.close
      file_lines
    end

    def definitions
      df = []
      lines.each_with_index do |line,i|
        if self.class.keywords.any?{|k| line.include?(k)}
          df << Definition.new(line.strip,self,i+1)
        end
      end
      df
    end

  end

end