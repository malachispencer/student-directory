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
    dirs = Dir.glob('./directories/*.csv').map {|f| File.basename(f)}
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
      delete_from_directory(directory)
    when '9'
      selection
    end
  end

  def rename_directory(directory)
    puts "You are renaming #{directory}"
    puts 'Enter new filename'
    filename = CreateDirectory.validate_filename(STDIN.gets.chomp)
    File.rename("./directories/#{directory}", "./directories/#{filename}")
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
    CSV.open("./directories/#{directory}", 'a') do |row|
      students.each do |student|
        row << [student[:name], " #{student[:cohort]}"]
      end
    end
    noun = students.length == 1 ? 'student' : 'students'
    puts "#{students.length} #{noun} successfully added to #{directory}."
  end

  def delete_from_directory(directory)
    students = ShowDirectory.get_students(directory)
    Print.header(directory)
    Print.students(students)
    Print.delete_students_instruction
    indexes_to_delete = get_students_to_delete(students)
    confirm = confirm_delete(students, indexes_to_delete, directory)
    return if confirm == 'n'
    new_list = delete_students(students, indexes_to_delete)
    deleted = indexes_to_delete.length
    overwrite_directory(directory, new_list, deleted)
  end

  def get_students_to_delete(students)
    delete = STDIN.gets.chomp

    until valid_chars(delete) && valid_nums(delete, students.length)
      print 'Invalid, please enter a number, or numbers'
      puts ' seperated by commas only e.g. "9" or "1,3,5".'
      puts 'Ensure entry number is included in directory.'
      delete = STDIN.gets.chomp
    end

    delete.split(',').map {|n| n.to_i - 1}
  end

  def valid_chars(input)
    /^(\d)(,\d)*$/ === input
  end

  def valid_nums(input, max)
    input.split(',').map(&:to_i).all? {|n| n > 0 && n <= max}
  end

  def confirm_delete(students, indexes_to_delete, directory)
    to_be_deleted = students.reject.with_index do |student, i|
      !indexes_to_delete.include?(i)
    end

    Print.header
    Print.students(to_be_deleted)
    noun = to_be_deleted.length == 1 ? 'student' : 'students'
    print "\nAre you sure you wish to delete the" 
    puts " above #{noun} from #{directory} (y/n)?"
    confirm = STDIN.gets.chomp

    while !%w[y n].include?(confirm)
      puts 'Invalid! please enter y or n'
      confirm = STDIN.gets.chomp
    end

    confirm
  end

  def delete_students(students, indexes_to_delete)
    new_list = students.reject.with_index do |student,i| 
      indexes_to_delete.include?(i)
    end
    new_list
  end

  def overwrite_directory(directory, students, deleted)
    CSV.open("./directories/#{directory}", 'w') do |row|
      students.each do |student|
        row << [student[:name], " #{student[:cohort]}"]
      end
    end
    noun = deleted == 1 ? 'student' : 'students'
    puts "#{deleted} #{noun} deleted from #{directory}."
  end
end