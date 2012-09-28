# encoding: UTF-8

require 'amatch'

class String

  include Amatch
  
  def clean
    term = self.split(': ')[1]
    term.strip if term
  end
end