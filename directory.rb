def interactive_menu
  students = []

  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"

    selection = gets.chomp

    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print_students(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you mean, try again."
    end
  end
end

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  students = []

  while !name.empty?
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end

  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students(students)
  students.each do |student| 
    puts "#{student[:name]} (#{student[:cohort]})"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

interactive_menu