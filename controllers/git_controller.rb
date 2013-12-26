class GitController < ApplicationController

  helpers GitHelpers

  post '/clone' do
  end
  
  post '/pull' do
  	
  end

  post '/commit' do
  	message = params[:message]
  	commit message
  end
  
  post '/push' do
  end
  
  get '/current_branch' do
  end
  
  post '/branch' do
  end
  
end
