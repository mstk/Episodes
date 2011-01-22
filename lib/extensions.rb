class String
  
  def word_count
    self.scan(/\w+/).size
  end
  
end