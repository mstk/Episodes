require 'date'

# Jobs
#
# - Figure out last elapsed episode of its type
# - Search for past episodes of its type
# - Aggregate data
# - Create and store new episodes of its type
#
#
class Episode_Manager
  
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
  
  def intialize(type)
    @type = type
  end
  
  def last_elapsed
    today = Date.today
    day = case @type
    when :year    then Date.parse("#{today.year-1}-01-01")
    when :quarter then today.month < 4 ? Date.parse("#{today.year-1}-10-01") : today.month < 7 ? Date.parse("#{today.year}-01-01") : today.month < 10 ? Date.parse("#{today.year}-04-01") : Date.parse("#{today.year}-10-01")
    when :month   then Date.parse("#{today.prev_month.year}-#{today.prev_month.month}-#{01}")
    when :week    then today-(today.wday)
    when :day     then today.prev_day
    end
    
    fetch_episode(day)
  end
  
  def fetch_episode(start_date)
    Episode.get( :type => @type.to_s, :date => start_date )
  end
  
end