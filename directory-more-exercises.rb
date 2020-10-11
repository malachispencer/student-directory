require 'date'

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts 'Enter 1 to create new directory'
  puts 'Enter 2 to load existing directory'
  puts 'Enter 3 to update existing directory'
  puts 'Enter 4 to delete existing directory'
  puts 'Enter 9 to quit'
end

def process(selection)
  
end