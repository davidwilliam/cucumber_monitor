# encoding: UTF-8

class String
  
  def clean
    term = self.split(': ')[1]
    term.strip if term
  end
end