require 'date'

def interactive_menu
  loop do
    print_menu
    main_process(STDIN.gets.chomp)
  end
end

def print_menu
  puts '1. Create new directory'
  puts '2. Display existing directory'
  puts '3. Update existing directory'
  puts '4. Delete existing directory'
  puts '9. Exit'
end

def main_process(selection)
  case selection
  when '1'
    new_dir_process
  #when '2'
    #read_directory
  #when '3'
    #update_directory
  #when '4'
    #delete_directory
  when '9'
    exit
  else
    puts 'Invalid input, please choose a valid option.'
  end
end

def new_dir_process
  input_students_process
  save_students_process unless @students.empty?
end

def input_students_process
  @students = []

  loop do
    puts "Add a student to the directory? (y/n)"
    add_student = gets.chomp.downcase

    while !%w[y n].include?(add_student)
      puts "Invalid, please enter y or n."
      add_student = gets.chomp.downcase
    end

    break if add_student == 'n'
    push_student
  end
end

def push_student
  student = {}
  student[:name] = get_name
  student[:cohort] = get_cohort
  @students.push(student)

  if @students.length == 1
    puts "We have #{@students.length} student."
  else
    puts "We have #{@students.length} students."
  end
end

def save_students_process
  print_header
  print_students_list
  puts 'Would you like to save this list of students? (y/n)'
  save_list = STDIN.gets.chomp

  while !%w[y n].include?(save_list)
    puts "Invalid, please enter y or n."
    save_student = gets.chomp.downcase
  end

  save_students if save_list == 'y'
end

def save_students
  puts 'Enter filename'
  raw_filename = STDIN.gets.chomp
  filename = validate_filename(raw_filename)
  filename = "#{filename}.csv"
  file = File.open(filename, 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(', ')
    file.puts csv_line
  end
  file.close
end

def validate_filename(filename)
  until /^[\w\.\-]+$/ === filename
    print 'Valid filename includes '
    print 'letters, numbers, underscores, '
    puts 'dashes and periods only.'
    filename = STDIN.gets.chomp
  end
  filename
end

def get_name
  puts "Enter the student's name..."
  name = gets.chomp.downcase

  while name.empty?
    puts "Empty inputs are invalid!"
    name = gets.chomp.downcase
  end

  name
end

def get_cohort
  months = Date::MONTHNAMES[1..-1].map(&:downcase)
  puts "Enter the student's cohort..."
  cohort = gets.chomp.downcase

  while !months.include?(cohort)
    puts "Invalid! Please enter a month."
    cohort = gets.chomp.downcase
  end

  cohort
end

def print_header
  puts 'students list'.center(50)
  puts '----------'.center(50)
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} -- #{student[:cohort]}".center(50)
  end
end

interactive_menu