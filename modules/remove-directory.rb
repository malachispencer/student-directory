require 'fileutils'

module RemoveDirectory
  def instructions
    print 'Enter a directory from below to remove, '
    puts 'include file extension in the name.'
  end

  def get_directory
    dirs = Dir["*.csv"]
    dir_to_rm = STDIN.gets.chomp
  
    while !dirs.include?(dir_to_rm)
      puts 'Oops, file does not exist!'
      dir_to_rm = STDIN.gets.chomp
    end

    dir_to_rm
  end

  def remove_directory(directory)
    remove = are_you_sure?(directory)
    FileUtils.rm_rf("./#{directory}") if remove == 'y'
  end

  def are_you_sure?(directory)
    puts "Are you sure you wish to delete #{directory}?"
    puts 'Return y to continue.'
    puts 'Any other key will cancel the process.'
    remove = STDIN.gets.chomp
  end
end