module EpisodeRange
  
  def self.episode_start(type,date)
    case type
    when :year
      return date - (date.yday - 1)
    when :quarter
      proper_day = date.prev_month((date.month-1) % 3)
      return proper_day - (proper_day.mday - 1)
    when :month
      return date - (date.mday - 1)
    when :week
      return date - (date.wday)
    when :day
      return date
    end
  end
  
  def self.last_elapsed_start(type,date)
    case type
    when :year
      return self.episode_start(type,date.prev_year)
    when :quarter
      return self.episode_start(type,date.prev_month(3))
    when :month
      return self.episode_start(type,date.prev_month)
    when :week
      return self.episode_start(type,date - 7)
    when :day
      return self.episode_start(type,date.prev_day)
    end
  end
  
end