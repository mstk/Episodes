class User
  
  def most_recent_episode(type)
    start_day = EpisodeRange.last_elapsed_start(type,Date.tday)
    return get_episode(type,date)
  end
  
  def get_episode(type,date)
    all_matching = episodes.all(:type => @type.to_s, :date => date)
    return all_matching[0] if all_matching[0]
    
    blank_episode = Episode.new
    blank_episode.attributes = { :user => self, :type => type.to_s, :date => date }
    
    return blank_episode
  end
  
end