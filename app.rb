require_relative './modules/create-directory.rb'
require_relative './modules/show-directory.rb'
require_relative './modules/remove-directory.rb'
require_relative './modules/print.rb'
include CreateDirectory
include ShowDirectory
include RemoveDirectory
include Print

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
  students = CreateDirectory.add_students
  return if students.empty?
  Print.header
  Print.students(students)
  CreateDirectory.save_students?
end

def show_dir_process
  ShowDirectory.instructions
  Print.csv_files
  directory = ShowDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  Print.header(directory)
  Print.students(students)
end

def remove_dir_process
  RemoveDirectory.instructions
  Print.csv_files
  directory = RemoveDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  Print.header(directory)
  Print.students(students)
  RemoveDirectory.remove_directory(directory)
end

interactive_menu