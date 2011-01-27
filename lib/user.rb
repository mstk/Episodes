class User
  
  def most_recent_episode(type,date = Date.today)
    start_day = EpisodeRange.last_elapsed_start(type,date)
    return get_episode(type,start_day)
  end
  
  def episode_during_day(type,date)
    start_day = EpisodeRange.episode_start(type,date)
    return get_episode(type,start_day)
  end
  
  private
  
  def get_episode(type,date)
    all_matching = episodes.all(:type => type.to_s, :date => date)
    return all_matching[0] if all_matching[0]
    
    blank_episode = self.episodes.create(:type => type.to_s, :date => date)
    
    return blank_episode
  end
  
end