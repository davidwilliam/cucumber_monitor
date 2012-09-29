# encoding: UTF-8

module CucumberMonitor

  class Definition

    attr_accessor :description, :file, :line

    def initialize(description, file, line)
      @description = description
      @file = file
      @line = line
    end

    def matcher
      description.scan(/\/(.*)\//).flatten.first
    end

    def raw_content
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

    def content
      raw_content.collect{|c| c.strip }
    end

    def core_content
      content[1..-2].collect{|c| c.strip }
    end

    def location
      "#{file.file}:#{line}"
    end

    def location_path
      "#{file.path}:#{line}"
    end

  end

end