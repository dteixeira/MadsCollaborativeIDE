class ProjectController < ApplicationController

  helpers ProjectHelpers

  get '/create' do
    check_login
    slim 'project/create'.to_sym
  end

  get '/edit/:project' do |project|
  end

  get '/list' do
  end

  post '/create' do
    check_login
    p = params[:project].inject({}) { |memo,(k,v)| memo[k.to_sym] = v; memo }
    project = Project.new p
    project.user_id = @current_user.id
    if project.save
      flash[:notice] = 'Project created'
      # TODO CREATE REPO
      redirect "/edit/#{project.name}"
    else
      str = ''
      project.errors.each do |k, v|
        next if k.nil?
        str += k + ';'
      end
      flash[:error] = str
      redirect '/project/create'
    end
  end

end
