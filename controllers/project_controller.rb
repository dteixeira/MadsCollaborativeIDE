class ProjectController < ApplicationController

  helpers ProjectHelpers

  # Global file synchronization locks.
  @@file_locks = {}

  get '/create' do
    check_login
    slim 'project/create'.to_sym
  end

  get '/edit/:project' do |project|
    check_login
    @project = find_project project
    slim 'project/edit'.to_sym
  end

  get '/list' do
    check_login
    @projects = Project.all
    slim 'project/list'.to_sym
  end

  get '/git/:project' do |p|
    check_owner p
    @project = find_project p
    slim 'project/git'.to_sym
  end

  post '/git/commit/:project' do |p|
    begin
      message = params[:commit][:message]
      if message.nil? || message.empty? || message.strip.empty?
        flash[:error] = 'No commit message defined'
        redirect "/project/git/#{p}"
      end
      repo = open_git settings.browser_root, p
      repo.config('user.name', @current_user.username)
      repo.config('user.email', @current_user.email)
      repo.add
      repo.commit(message)
      flash[:notice] = 'Commit success'
      redirect "/project/git/#{p}"
    rescue Exception => e
      puts e
      flash[:error] = 'Nothing to commit'
      redirect "/project/git/#{p}"
    end
  end

  post '/git/push/:project' do |p|
  end

  post '/git/pull/:project' do |p|
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
        Dir.chdir(settings.browser_root)
        Git.clone project.repo_url, project.name
        redirect "/project/edit/#{project.name}"
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

  # Saves file to disk.
  post '/save_file/:project' do |p|
    file = params[:file]
    content = params[:content] || ''
    path = project_path settings.browser_root, p
    hash = generate_hash(p, file)
    return { success: false }.to_json if file.nil? || file.empty? || !valid_file(path, file)
    @@file_locks[p] = {} if @@file_locks[p].nil?
    @@file_locks[p][hash] = Mutex.new if @@file_locks[p][hash].nil?
    @@file_locks[p][hash].synchronize do
      save_file path, file, content
    end
  end

end
