# encoding: UTF-8

module CucumberMonitor

  class Context

    attr_accessor :name, :feature

    def initialize(name,feature)
      @name = name
      @feature = feature
    end

    def steps
      st = []
      started = false
      stopped = false
      record = false
      count = 0
      feature.lines.each_with_index do |line, i|
        if line.include?(I18n.t("background"))
          started = true
        end
        if started && !stopped
          st << Step.new(line.strip, self, i+1) unless (count == 0 || line.strip.blank?)
          stopped = true if line.strip.blank?
          count += 1
        end
      end
      st
    end

  end

end