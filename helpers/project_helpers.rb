module ProjectHelpers

  def find_project project
    Project.first(:name => project)
  end

  def project_path root, project
    File.join(root, project)
  end

  def open_git root, project
    repo = File.join(root, project)
    Git.open(repo, :log => Logger.new(STDOUT))
  end

  def check_owner project
    check_login
    p = find_project project
    if p.nil?
      flash[:error] = "This project does not exist"
      redirect '/'
    elsif p.user_id != @current_user.id
      flash[:error] = "Only the creator of a project can manage it"
      redirect '/'
    end
  end

  # Checks if file exists, is under root and is a text file.
  def valid_file root, file
    path = File.join(root, file)
    path[0, root.length] == root && File.file?(path) && !File.binary?(path)
  end

  # Loads a file's contents to a string.
  def load_file root, file
    content = nil
    begin
      if valid_file root, file
        path = File.join(root, file)
        File.open(path, "r") do |f|
          content = f.read
        end
      end
    rescue Exception => e
      puts e
      content = nil
    end
    content
  end

  # Saves a file's contents to disk.
  def save_file root, file, content
    begin
      if valid_file root, file
        path = File.join(root, file)
        File.open(path, "w") do |f|
          f.write content
        end
      end
    rescue Exception => e
      puts e
    end
  end

  # Any helper code for the MainController should be defined here.
  def list_directory root, dir
    files = { files: [], dirs: [] }
    begin
      path = File.join(root, dir)
      return files unless File.directory?(path)
      Dir.chdir(File.expand_path(path).untaint);

      # Provided directory is not under defined root;
      # prevents root spoofing.
      if Dir.pwd[0, root.length] == root then

        # Finds directories.
        Dir.glob("*") do |x|
          next if not File.directory?(x.untaint)
          files[:dirs] << { name: x, path: dir + x + '/' }
        end

        # Finds files.
        Dir.glob("*") do |x|
          next if not File.file?(x.untaint)
          ext = File.extname(x)[1..-1]
          files[:files] << { name: x, path: dir + x, ext: ext }
        end
      else
        files = nil
      end
    rescue Exception => e
      puts e
      files = nil
    end
    files
  end

  # Generate a files hash.
  def generate_hash project, file
    Digest::SHA1.hexdigest project + file
  end

end
