require "date"

def get_name
  puts "Enter the student's name..."
  name = gets.chomp.downcase

  while name.empty?
    puts "Empty inputs are invalid!"
    name = gets.chomp.downcase
  end

  name
end

def get_location
  puts "Enter the student's city of residence..."
  location = gets.chomp.downcase

  while location.empty?
    puts "Empty inputs are invalid!"
    location = gets.chomp.downcase
  end

  location
end

def get_cohort
  months = Date::MONTHNAMES[1..-1]
  puts "Enter the student's cohort..."
  cohort = gets.chomp.capitalize

  while !months.include?(cohort)
    puts "Invalid! Please enter a month."
    cohort = gets.chomp.capitalize
  end

  cohort
end

def input_students
  students = []

  loop do

    puts "Add a student to the directory? (y/n)"
    add_student = gets.chomp.downcase

    while !%w[y n].include?(add_student)
      puts "Invalid, please enter y or n."
      add_student = gets.chomp.downcase
    end

    break if add_student == "n"
    
    student = {}
    student[:name] = get_name
    student[:location] = get_location
    student[:cohort] = get_cohort

    students.push(student)
  end

  students
end