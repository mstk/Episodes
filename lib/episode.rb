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
      :type       => @type,
      :body       => @body || body || '',
      :word_count => @word_count,
      :created_at => @created_at,
      :updated_at => @updated_at,
      :scores     => @scores,
      :meta       => @meta }
  end
  
  @@TYPES = [ :year, :quarter, :month, :week, :day ]
  
  def self.zoom_out_type(type)
    type_id = @@TYPES.index(type)
    if type_id == 0
      return nil
    else
      return @@TYPES[type_id-1]
    end
  end
  
  def self.zoom_in_type(type)
    type_id = @@TYPES.index(type)
    if type_id == 4
      return nil
    else
      return @@TYPES[type_id+1]
    end
  end
  
end