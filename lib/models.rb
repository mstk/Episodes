class Episode
  include DataMapper::Resource

  property :id,         Serial
  property :date,       Date
  property :type,       String
  property :body,       Text
  property :word_count, Integer
  property :created_at, DateTime
  property :scores,     Yaml,     :default => lambda { Hash.new(0) }
  property :meta,       Yaml
  
  
end

# class YearEpisode    < Episode
# end

# class QuarterEpisode < Episode
# end

# class MonthEpisode   < Episode
# end

# class WeekEpisode    < Episode
# end

# class DayEpisode     < Episode
# end