class User
  include DataMapper::Resource

  property :id,         Serial
  property :email,      String, :length => (5..40), :unique => true, :format => :email_address
  property :username,   String, :length => (2..32), :unique => true
  property :hashed_password, String
  property :salt,       String
  property :created_at, DateTime
  property :access,     Integer, :default => 2
  property :active,     Boolean, :default => true
  
  has n, :episodes
  
  # 0: admin
  # 1: mod
  # 2: user
  
end

class Episode
  include DataMapper::Resource

  property :id,         Serial
  property :date,       Date,     :required => true
  property :type,       String,   :required => true
  property :body,       Text,     :default  => ''
  property :word_count, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  property :scores,     Yaml,     :default => proc { Hash.new(0) }
  property :meta,       Yaml,     :default => proc { Hash.new(0) }
  property :locked,     Boolean,  :default => false
  
  belongs_to :user
  
end