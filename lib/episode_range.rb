module EpisodeRange
  
  def self.episode_start(type,date)
    case type
    when :year
      return curr_day - (curr_day.yday - 1)
    when :quarter
      proper_day = curr_day.prev_month((curr_day.month-1) % 3)
      return proper_day - (proper_day.mday - 1)
    when :month
      return curr_day - (curr_day.mday - 1)
    when :week
      return curr_day - (curr_day.wday)
    when :day
      return curr_day
    end
  end
  
  def self.last_elapsed_start(type,date)
    case @type
    when :year
      return episode_start(from_day.prev_year)
    when :quarter
      return episode_start(from_day.prev_month(3))
    when :month
      return episode_start(from_day.prev_month)
    when :week
      return episode_start(from_day - 7)
    when :day
      return episode_start(from_day.prev_day)
    end
  end
  
end