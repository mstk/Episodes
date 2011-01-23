class Episode
  include DataMapper::Resource

  property :id,         Serial
  property :author,     String,   :default => 'Justin'
  property :date,       Date,     :required => true
  property :type,       String,   :required => true
  property :body,       Text,     :default  => ''
  property :word_count, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  property :scores,     Yaml,     :default => proc { Hash.new(0) }
  property :meta,       Yaml,     :default => proc { Hash.new(0) }
  property :locked,     Boolean,  :default => false
  
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
  
  def end_date
    Episode_Manager.EM(@type.intern).end_date(@date)
  end
  
end