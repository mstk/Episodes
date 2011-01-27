class Episode
  
  before :save do
    word_count = count_words
  end
  
  def count_words
    if body
      body.word_count
    else
      0
    end
  end
  
  def to_json
    to_hash.to_json
  end
  
  def to_hash
    { :id         => @id,
      :date       => @date,
      :end_date   => end_date,
      :type       => @type,
      :body       => @body || body || '',
      :word_count => @word_count,
      :created_at => @created_at,
      :updated_at => @updated_at,
      :scores     => @scores,
      :meta       => @meta }
  end
  
end