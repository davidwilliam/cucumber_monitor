# encoding: UTF-8

module CucumberMonitor

  class Definition

    attr_accessor :description, :file

    def initialize(description, file)
      @description = description
      @file = file
    end

    def content
      df = []
      started = false
      stopped = false
      record = false
      count = 0

      file.lines.each_with_index do |line, i|

        if line.include?(description)
          started = true
        end
        if started && !stopped
          df << line
          stopped = true if line.strip.match(/^end$/)
          count += 1
        end
      end
      df
    end

    def core_content
      content[1..-2].collect{|c| c.strip }
    end

  end

end