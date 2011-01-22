class Episode
  include DataMapper::Resource

  property :id,         Serial
  property :date,       Date,     :required => true
  property :type,       String,   :required => true
  property :body,       Text,     :default  => ''
  property :word_count, Integer
  property :created_at, DateTime
  property :scores,     Yaml,     :default => lambda { Hash.new(0) }
  property :meta,       Yaml,     :default => lambda { Hash.new(0) }
  
  before :save do
    if @body
      @word_count = @body.word_count
    else
      @word_count = 0
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
      :scores     => @scores,
      :meta       => @meta }
  end
  
  def end_date
    Episode_Manager.EM(@type.intern).end_date(@date)
  end
  
end