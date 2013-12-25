module FileHelpers

  # Any helper code for the MainController should be defined here.
  def list_directory root, dir
    files = { files: [], dirs: [] }
    begin
      path = File.join(root, dir)
      Dir.chdir(File.expand_path(path).untaint);

      # Provided directory is not under defined root;
      # prevents root spoofing.
      if Dir.pwd[0,root.length] == root then

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

end
