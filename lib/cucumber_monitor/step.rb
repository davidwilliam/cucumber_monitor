module CucumberMonitor

  class Step

    attr_accessor :description, :code, :parent, :id

    def initialize(description, parent, id)
      @description = description.strip
      code_first_part = parent.name.blank? ? parent.keyword.parameterize : parent.name.parameterize
      code_second_part = @description.parameterize
      @code = "#{code_first_part}-#{code_second_part}"
      @parent = parent
      @id = id
    end

    def description_without_keyword
      description.gsub(/^\w+\s/,'')
    end

    def siblings_and_self
      parent.steps
    end

    def previous
      siblings_and_self.where(id: self.id - 1)
    end

    def next
      siblings_and_self.where(id: self.id + 1)
    end

    def table?
      description.scan(/\|/).length >= 2 && description[0] == "|" && description[-1] == "|"
    end

    def table_first_line?
      table? && (self.previous.blank? || self.previous.not_a_table)
    end

    def table_last_line?
      table? && (self.next.blank? || self.next.not_a_table)
    end

    def table_row?
      table? && !table_first_line?
    end

    def table_content
      if table?
        description.split("|").map{|l| l.strip}[1..-1]
      end
    end

    def not_a_table
      !table?
    end

    def formatted
      output = ""
      if table_first_line?
        output << "<table>\n"
        output << "  <tr>\n"
        table_content.each do |th|
          output << "    <th>#{th}</th>\n"
        end
        output << "    <th>&nbsp;</th>"
        output << "  </tr>\n"
        output << "</table>\n" if table_last_line?
      elsif table_row?
        output << "  <tr>\n"
        table_content.each do |td|
          output << "    <td>#{td}</td>\n"
        end
        output << "    <td class='td_result'>&nbsp;</td>"
        output << "  </tr>\n"
        output << "</table>\n" if table_last_line?
      else
        output << description
      end
      output
    end

  end

end