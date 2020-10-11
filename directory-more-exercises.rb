require 'date'

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts '1. Create new directory'
  puts '2. Display existing directory'
  puts '3. Update existing directory'
  puts '4. Delete existing directory'
  puts '9. Exit'
end

def process(selection)
  case selection
  when '1'
    input_students
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

interactive_menu