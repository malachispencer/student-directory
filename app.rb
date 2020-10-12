require 'fileutils'
require './modules/create-directory.rb'
require './modules/show-directory.rb'
include CreateDirectory
include ShowDirectory

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
    create_directory
  when '2'
    show_directory
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

# CREATE NEW DIRECTORY

def create_directory
  CreateDirectory.add_students?
  CreateDirectory.save_students?
end

# DISPLAY DIRECTORY

def show_directory
  print 'Choose a directory from below to display,'
  puts ' include the file extension.'
  display_csv_files
  
  directory = ShowDirectory.get_directory
  students = ShowDirectory.get_students(directory)
  print_header(directory)
  print_students_list(students)
end

# DELETE DIRECTORY

def remove_dir_process
  print 'Enter a directory from below to remove, '
  puts 'include file extension in the name.'
  display_csv_files
  remove_dir
end

def remove_dir
  dirs = Dir["*.csv"]
  dir_to_rm = STDIN.gets.chomp

  while !dirs.include?(dir_to_rm)
    puts 'Oops, file does not exist!'
    dir_to_rm = STDIN.gets.chomp
  end

  rm_dir = validate_dir_to_rm(dir_to_rm)
  FileUtils.rm_rf("./#{dir_to_rm}") if rm_dir == 'y'
end

def validate_dir_to_rm(dir_name)
  puts "Are you sure you wish to delete #{dir_name}?"
  puts 'Return y to continue, any other input will cancel the process.'
  rm_dir = STDIN.gets.chomp
end

# PRINTING

def print_header(filename = 'list')
  puts "students in #{filename}".center(50)
  puts '----------------'.center(50)
end

def print_students_list(students = @students)
  students.each do |student|
    puts "#{student[:name]} -- #{student[:cohort]}".center(50)
  end
end

def display_csv_files
  print "#{Dir["*.csv"].join(' - ')}\n"
end

interactive_menu