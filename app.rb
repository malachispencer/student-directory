require './modules/create-directory.rb'
require './modules/show-directory.rb'
require './modules/remove-directory.rb'
include CreateDirectory
include ShowDirectory
include RemoveDirectory

def interactive_menu
  loop do
    print_menu
    menu_process(STDIN.gets.chomp)
  end
end

def print_menu
  puts '1. Create new directory'
  puts '2. Show existing directory'
  puts '3. Update existing directory'
  puts '4. Delete existing directory'
  puts '9. Exit'
end

def menu_process(selection)
  case selection
  when '1'
    create_dir_process
  when '2'
    show_dir_process
  #when '3'
    #update_directory
  when '4'
    remove_dir_process
  when '9'
    exit
  else
    puts 'Invalid input, please choose a valid option.'
  end
end

def create_dir_process
  CreateDirectory.add_students?
  CreateDirectory.save_students?
end

def show_dir_process
  ShowDirectory.instructions
  display_csv_files
  directory = ShowDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  print_header(directory)
  print_students(students)
end

def remove_dir_process
  RemoveDirectory.instructions
  display_csv_files
  directory = RemoveDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  print_header(directory)
  print_students(students)
  RemoveDirectory.remove_directory(directory)
end

def print_header(filename = 'list')
  puts "students in #{filename}".center(50)
  puts '----------------'.center(50)
end

def print_students(students = @students)
  students.each do |student|
    puts "#{student[:name]} -- #{student[:cohort]}".center(50)
  end
end

def display_csv_files
  print "#{Dir["*.csv"].join(' - ')}\n"
end

interactive_menu