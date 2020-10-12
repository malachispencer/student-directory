module DisplayDirectory
  def get_directory
    dirs = Dir["*.csv"]
    dir_to_show = STDIN.gets.chomp.downcase
  
    while !dirs.include?(dir_to_show)
      puts 'Oops, file does not exist!'
      dir_to_show = STDIN.gets.chomp
    end
  
    dir_to_show
  end
  
  def get_students(filename)
    @students = []
    file = File.open(filename, 'r')
    file.readlines.each do |line|
      name, cohort = line.chomp.split(', ')
      @students << {name: name, cohort: cohort}
    end
    @students
  end
end