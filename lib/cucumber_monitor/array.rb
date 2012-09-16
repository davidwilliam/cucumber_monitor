# encoding: UTF-8

class Array
  def where(options={})
    result = []
    self.each do |item|
      if item.respond_to?(:name) && item.name.include?(options[:name])
        result << item
      end

      if item.respond_to?(:description) && !item.description.nil? && !options[:description].nil? && item.description.include?(options[:description])
        result << item
      end

      if item.respond_to?(:id) && item.id == options[:id]
        result << item
      end
    end

    result.uniq!

    if result.size == 1
      result.first
    else
      result
    end
  end

end