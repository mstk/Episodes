# Jobs
# 
# - Episode Manager Traversal between different types
# - get data for "tree" of episodes
# 
module Type_Manager
  
  @@TYPES = [ :year, :quarter, :month, :week, :day ]
  
  
  def Type_Manager.zoom_out(episode)
    type = Type_Manager.zoom_out_type(episode.type.intern)
    return type if type.nil?
    Episode_Manager.EM(type).current(episode.date)
  end
  
  def Type_Manager.zoom_in(episode)
    type = Type_Manager.zoom_in_type(episode.type.intern)
    return type if type.nil?
    Episode_Manager.EM(type).current(episode.date)
  end
  
  def Type_Manager.zoom_out_type(type)
    type_id = @@TYPES.index(type)
    if type_id == 0
      return nil
    else
      return @@TYPES[type_id-1]
    end
  end
  
  def Type_Manager.zoom_in_type(type)
    type_id = @@TYPES.index(type)
    if type_id == 4
      return nil
    else
      return @@TYPES[type_id+1]
    end
  end
  
end