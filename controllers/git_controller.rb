class GitController < ApplicationController

  helpers GitHelpers

  post '/clone' do
  	clone 'git@github.com:dteixeira/MadsCollaborativeIDE.git', 'testrepo', '/home/misirlou/test/'
  	return "true"
  end
  
  post '/pull' do
  	
  end

  post '/commit' do
  	message = params[:message]
  	return commit message
  end
  
  post '/push' do
  end
  
  get '/current_branch' do
  end
  
  post '/branch' do
  end
  
  get '/status' do
  	#puts status.inspect
  	return status.inspect
  end
end
