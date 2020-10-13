require_relative './modules/create-directory.rb'
require_relative './modules/show-directory.rb'
require_relative './modules/update-directory.rb'
require_relative './modules/remove-directory.rb'
require_relative './modules/print.rb'
include CreateDirectory
include ShowDirectory
include UpdateDirectory
include RemoveDirectory
include Print

def interactive_menu
  Dir.mkdir('./directories') unless Dir.exist?('./directories')

  loop do
    Print.main_menu
    menu_process(STDIN.gets.chomp)
  end
end

def menu_process(selection)
  case selection
  when '1'
    create_dir_process
  when '2'
    show_dir_process
  when '3'
    update_directory
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
  ShowDirectory.show_instruction
  Print.csv_files
  directory = ShowDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  Print.header(directory)
  Print.students(students)
end

def update_directory
  Print.update_menu
  selection, action = UpdateDirectory.get_update_action(STDIN.gets.chomp)
  return if selection == '9'
  Print.update_instruction(action)
  Print.csv_files
  dir_to_update = UpdateDirectory.get_dir_to_update
  UpdateDirectory.process_update_action(selection, dir_to_update)
end

def remove_dir_process
  RemoveDirectory.remove_instructions
  Print.csv_files
  directory = RemoveDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  Print.header(directory)
  Print.students(students)
  RemoveDirectory.remove_directory(directory)
end

interactive_menu