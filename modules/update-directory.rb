require 'csv'

module UpdateDirectory

  ACTIONS = {
    '1': 'rename',
    '2': 'add students to',
    '3': 'delete students from'
  }
  
  def get_update_action(selection)

    while !%w[1 2 3 4 9].include?(selection)
      puts 'Invalid! Please pick a valid action.'
      puts '1. Rename a directory'
      puts '2. Add students to a directory'
      puts '3. Delete students from a directory'
      puts '9. Go back to main menu'
      selection = STDIN.gets.chomp
    end

    [selection, ACTIONS[selection.to_sym]]
  end

  def get_dir_to_update
    dirs = Dir['*.csv']
    dir_to_update = STDIN.gets.chomp

    while !dirs.include?(dir_to_update)
      puts 'Oops, file does not exist!'
      dir_to_update = STDIN.gets.chomp
    end

    dir_to_update
  end

  def process_update_action(selection, directory)
    case selection
    when '1'
      rename_directory(directory)
    when '2'
      append_to_directory(directory)
    when '3'
      #delete_students_from_dir
      puts 'deleting...'
    when '9'
      selection
    end
  end

  def rename_directory(directory)
    puts "You are renaming #{directory}"
    puts 'Enter new filename'
    filename = CreateDirectory.validate_filename(STDIN.gets.chomp)
    File.rename(directory, "#{filename}")
    puts "#{directory} renamed to #{filename}."
  end
 
  def append_to_directory(directory)
    students = CreateDirectory.add_students
    return if students.empty?
    Print.header
    Print.students(students)
    append = append_students?(directory)
    append_students(directory, students) if append == 'y'
  end
  
  def append_students?(directory)
    puts "\nWould you like to add this list of students to #{directory}? (y/n)"
    append = STDIN.gets.chomp
    
    while !%w[y n].include?(append)
      puts "Invalid, please enter y or n."
      append = gets.chomp.downcase
    end
    
    append
  end

  def append_students(directory, students)
    CSV.open(directory, 'a') do |row|
      students.each do |student|
        row << [student[:name], " #{student[:cohort]}"]
      end
    end
    noun = students.length == 1 ? 'student' : 'students'
    puts "#{students.length} #{noun} successfully added to #{directory}."
  end





end