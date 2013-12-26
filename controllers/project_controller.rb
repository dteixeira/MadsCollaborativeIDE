class ProjectController < ApplicationController

  helpers ProjectHelpers

  get '/create' do
    check_login
    slim 'project/create'.to_sym
  end

  post '/create' do
  end

end
