require 'date'

# Jobs
#
# - Figure out last elapsed episode of its type X
# - Search for past episodes of its type
# - Aggregate data
# - Create and store new episodes of its type
# - Determine if episodes are "open" for creation.
#
#
class Episode_Manager
  
  attr_reader :type
  
  private_class_method :new
  
  @@BOUNDIARS = { :year     => lambda { |d| d.mday == 0 && d.month == 1 },
                  :quarter  => lambda { |d| d.mday == 0 && (d.month-1) % 3 == 0 },
                  :month    => lambda { |d| d.mday == 0 },
                  :week     => lambda { |d| d.wday == 0 },
                  :day      => lambda { true }                                    }
  
  @@EM_INDEX = Hash.new do |h,t|
    h[t] = new(t)
  end
  
  def Episode_Manager.EM(type)
    @@EM_INDEX[type]
  end
  
  def initialize(type)
    @type = type
  end
  
  def current(curr_day = Date.today)
    case @type
    when :year
      day = curr_day - (curr_day.yday - 1)
    when :quarter
      proper_day = curr_day.prev_month((curr_day.month-1) % 3)
      day = proper_day - (proper_day.mday - 1)
    when :month
      day = curr_day - (curr_day.mday - 1)
    when :week
      day = curr_day - (curr_day.wday)
    when :day
      day = curr_day
    end
    
    fetch_episode(day)
  end
  
  def last_elapsed(from_day = Date.today)
    case @type
    when :year
      return current(from_day.prev_year)
    when :quarter
      return current(from_day.prev_month(3))
    when :month
      return current(from_day.prev_month)
    when :week
      return current(from_day - 7)
    when :day
      return current(from_day.prev_day)
    end
  end
  
  def end_date(from_day = Date.today)
    case @type
    when :year
      return (from_day - (from_day.yday - 1)).next_year.prev_day
    when :quarter
      proper_day = from_day.prev_month((from_day.month-1) % 3)
      return (proper_day - (proper_day.mday - 1)).next_month(3).prev_day
    when :month
      return (from_day - (from_day.mday - 1)).next_month
    when :week
      return (from_day - (from_day.wday)).next_day(6)
    when :day
      return from_day
    end
  end
  
  def fetch_episode(start_date)
    all_matching = Episode.all(:type => @type.to_s, :date => start_date)
    return all_matching[0] if all_matching[0]
    return Episode.create(:type => @type.to_s, :date => start_date)
  end
  
  def is_open(date)
    return current(date) <= last_elapsed
  end
  
end