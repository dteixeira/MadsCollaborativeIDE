class ProjectController < ApplicationController

  helpers ProjectHelpers

  get '/create' do
    check_login
    slim 'project/create'.to_sym
  end

  get '/edit/:project' do |project|
    check_login
    slim 'project/edit'.to_sym
  end

  get '/list' do
  end

  post '/create' do
    check_login
    begin
      p = params[:project].inject({}) { |memo,(k,v)| memo[k.to_sym] = v; memo }
      p[:name] = p[:name].downcase.gsub(/\s+/, '_')
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
    rescue
      flash[:error] = 'Failed to create a new project'
      redirect '/project/create'
    end
  end

  # List a directory to the first depth level.
  post '/list_directory/:project' do |p|
    @files = list_directory project_path(settings.browser_root, p), params[:dir]
    slim 'project/_list'.to_sym, :layout => :bare_layout
  end

  # Returns the unique hash of a file.
  post '/file_hash/:project' do |p|
    file = params[:file]
    path = project_path settings.browser_root, p
    return { success: false }.to_json if file.nil? || file.empty? || !valid_file(path, file)
    return { success: true, hash: generate_hash(p, file), project: p }.to_json
  end

  # Returns a files contents.
  post '/load_file/:project' do |p|
    file = params[:file]
    path = project_path settings.browser_root, p
    return { success: false }.to_json if file.nil? || file.empty? || !valid_file(path, file)
    content = load_file path, file
    return { success: false }.to_json unless file
    return { success: true, content: content }.to_json
  end

end
