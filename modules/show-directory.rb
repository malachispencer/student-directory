module ShowDirectory
  def show_instruction
    print 'Enter a directory from below to display,'
    puts ' include the file extension.'
  end

  def get_directory
    dirs = Dir.glob('./directories/*.csv').map {|f| File.basename(f)}
    dir_to_show = STDIN.gets.chomp.downcase
  
    while !dirs.include?(dir_to_show)
      puts 'Oops, file does not exist!'
      dir_to_show = STDIN.gets.chomp
    end
  
    dir_to_show
  end
  
  def get_students(directory)
    @students = []
    file = File.open("./directories/#{directory}", 'r')
    file.readlines.each do |line|
      name, cohort = line.chomp.split(', ')
      @students << {name: name, cohort: cohort}
    end
    file.close
    @students
  end
end