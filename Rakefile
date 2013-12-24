################################################################################
# This Rakefile contains some utility functions that are mainly use to clean
# the bootstrap after cloning. Users are welcome to modify it and add any tasks
# that they need.
#
# Diogo Teixeira, 2013
################################################################################

# Default task.
task :default => []

# Creates empty dummy files in empty folders to maintain the folder structure
# in the git tracking system.
task :create_dummies do
  Dir.glob('**/') do |dir|
    count = Dir[File.join(dir, '**', '*')].count
    if count == 0
      File.write File.join(dir, 'dummy'), ''
      puts 'Creating dummy in ' + dir
    end
  end
end

# Removes any dummy files that are no longer needed.
task :remove_dummies do
  Dir.glob('**/') do |dir|
    count = Dir[File.join(dir, '**', '*')].count
    if count > 1
      file = File.join(dir, 'dummy')
      if File.exist? file
        File.delete(file)
        puts 'Deleting ' + file
      end
    end
  end
end

# Removes all dummy files.
task :remove_all_dummies do
  Dir.glob('**/dummy') do |file|
    File.delete(file) if File.exist?(file)
    puts 'Deleting ' + file
  end
end
