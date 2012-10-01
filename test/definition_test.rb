require 'test_helper'

def definition_sample_codes
  [
    "User.create(email: email, password: password)",
    "visit new_user_session_url",
    "fill_in 'Email', with: email",
    "fill_in 'Password', with: password",
    "fill_in('Email', with: email)",
    "click_button 'Access'",
    "click_link 'Logout'",
    "assert_equal new_user_session_url, current_url",
    "assert_equal user_root_path, current_path",
    "assert page.has_content?(string)",
    "sign_in(:user, User.make!)"
  ]
end

def has_parentheses?(line)
  line.scan(/\((.*)\)/).flatten.any?
end

def first_method_without_parentheses?(line)
  line.scan(/\w+\s/).any?
end

def between_parentheses(line)
  line.scan(/\((.*)\)/).flatten.first
end

def has_comma?(line)
  line.scan(/,/).any?
end

def between_comma(line)
  line.split(",").map{|o| o.strip}
end

def has_new_hash_key?(line)
  line.scan(/\w+:/).any?
end

def new_hash_keys(line)
  result = []
  if line.kind_of?(Array)
    line.each do |l|
      result << l.scan(/\w+:/).map{|l| l.strip.gsub(/:/,'')}
    end
  else
    result << line.scan(/\w+:/).map{|l| l.strip.gsub(/:/,'')}
  end
  result.flatten
end

def new_hash_values(line)
  result = []
  if line.kind_of?(Array)
    line.each do |l|
      result << l.split(/\w+:/).map{|o| o.strip.gsub(/,/,"")}.reject{|s| s.empty?}
    end
  else
    result << line.split(/\w+:/).map{|l| l.strip.gsub(/,/,"")}.reject{|s| s.empty?}
  end
  result.flatten
end

def new_hash_keys_and_values(line)
  result = {}
  keys = new_hash_keys(line)
  values = new_hash_values(line)
  if keys.size == values.size
    keys.each_with_index do |k,i|
      result.merge!({k.to_sym => values[i]})
    end
  end
  result
end

def inspect_line(line)
  result = {}
  if !first_method_without_parentheses?(line) && !has_new_hash_key?(line)
    
    lines = line.split(/\((.*)\)/)
    result.merge!(method: lines[0])
    rest = between_comma(lines[1..-1].first)
    rest.each_with_index do |l,i|
      key_name = "param_#{i+1}"
      result.merge!({key_name.to_sym => l})
    end
  elsif first_method_without_parentheses?(line) && !has_new_hash_key?(line)

    lines = line.split(" ")
    result.merge!(method: lines[0])
    result.merge!(param_1: lines[1].gsub(/,/,"")) if lines[1]
    
    rest = lines[2..-1].join(" ")
    if !rest.blank? && !has_comma?(rest) && has_new_hash_key?(rest)

      result.merge!(options: new_hash_keys_and_values(rest))
    else
      lines[2..-1].each_with_index do |l,i|
        key_name = has_new_hash_key?(l) ? :options : "param_#{i+2}"

        if key_name == :options
          value = new_hash_keys_and_values(l)
        else
          value = l
        end
        result.merge!({key_name.to_sym => value})
        end
    end
  elsif first_method_without_parentheses?(line) && has_new_hash_key?(line)
    lines = line.split(" ")
    result.merge!(method: lines[0])
    rest = lines[1..-1].join(" ")
    if new_hash_keys_and_values(rest).blank? && has_comma?(rest)
      param_data = between_comma(rest)
      param_data.each_with_index do |p,i|
        key_name = "param_#{i+1}"
        value = p
        if has_new_hash_key?(value)
          result.merge!(options: new_hash_keys_and_values(value))
        else
          result.merge!({key_name.to_sym => value})
        end
      end
    end
  elsif !first_method_without_parentheses?(line) && has_parentheses?(line)

    lines = line.split(/\((.*)\)/)
    result.merge!(method: lines[0])
    within_parentheses = between_parentheses(line)
    if new_hash_keys_and_values(within_parentheses).blank? && has_comma?(within_parentheses)
      param_data = between_comma(within_parentheses)
      param_data.each_with_index do |p,i|
        key_name = "param_#{i+1}"
        value = p
        if has_new_hash_key?(value)
          result.merge!(options: new_hash_keys_and_values(value))
        else
          result.merge!({key_name.to_sym => value})
        end
      end
    elsif !new_hash_keys_and_values(within_parentheses).blank?
      result.merge!(param_1: new_hash_keys_and_values(within_parentheses))
    end
  end
  result
end

class DefinitionTest < ActiveSupport::TestCase

  test "should return identify params from code" do
    # code = definition_sample_codes[0]
    # info_between_parentheses = between_parentheses(code)
    # info_between_comma = between_comma(info_between_parentheses)
    # info_new_hash_keys = new_hash_keys(info_between_comma)
    # info_new_hash_values = new_hash_values(info_between_comma)

    # puts "_________________________________________________________"

    # puts "Inspecting:"

    puts "line 1: #{inspect_line(definition_sample_codes[0])}"
    puts "line 3: #{inspect_line(definition_sample_codes[1])}"
    puts "line 3: #{inspect_line(definition_sample_codes[2])}"
    puts "line 4: #{inspect_line(definition_sample_codes[3])}"
    puts "line 5: #{inspect_line(definition_sample_codes[4])}"
    puts "line 6: #{inspect_line(definition_sample_codes[5])}"
    puts "line 7: #{inspect_line(definition_sample_codes[6])}"
    puts "line 8: #{inspect_line(definition_sample_codes[7])}"
    puts "line 9: #{inspect_line(definition_sample_codes[8])}"
    puts "line 10: #{inspect_line(definition_sample_codes[9])}"
    puts "line 11: #{inspect_line(definition_sample_codes[10])}"

    # code = "'Email', with: email"
    # puts new_hash_keys_and_values(code)

  end
end