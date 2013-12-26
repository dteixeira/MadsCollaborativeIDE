module GitHelpers

  
  def commit message
    g = open
    g.config('user.name', 'lolol')
    g.config('user.email', 'coisas@ni.fe.up.pt')
    g.add
    g.commit(message)
    return true
  end
  
  def status
  	g = open
    return g.status
  end
  
  def clone remote, repo, path
    Git.clone(remote, repo, :path => path)
  end
  
  def open
  	return Git.open("/home/misirlou/test/testrepo", :log => Logger.new(STDOUT)) 
  end
  
  
end
