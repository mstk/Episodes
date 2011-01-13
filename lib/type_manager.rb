# Jobs
# 
# - Episode Manager Traversal between different types
#
class Type_Manager
  
  private_class_method :new
  
  def Type_Manager.TM
    @@tm = new unless @@tm
    @@tm
  end
  
end