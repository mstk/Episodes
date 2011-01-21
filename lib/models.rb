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
    word_count = body.word_count
  end
  
end