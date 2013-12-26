module GitHelpers

  
  def commit message
    g = open
    
  end
  
  def status
  	g = open
    
  end
  
  def open
  	return Git.open("/home/misirlou/MadsCollaborativeIDE", :log => Logger.new(STDOUT)) 
  end
  
end
