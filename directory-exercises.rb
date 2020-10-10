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
  months = Date::MONTHNAMES[1..-1].map(&:downcase)
  puts "Enter the student's cohort..."
  cohort = gets.chomp.downcase

  while !months.include?(cohort)
    puts "Invalid! Please enter a month."
    cohort = gets.chomp.downcase
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

    if students.length == 1
      puts "We have #{students.length} student."
    else
      puts "We have #{students.length} students."
    end
  end

  students
end

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print_students(students)
  students.each_with_index do |student, i| 
    puts "#{i + 1}. #{student[:name]} -- #{student[:location]} -- #{student[:cohort]}".center(100)
  end
end

def print_by_cohort(students, cohort)
  students = students.reject {|student| student[:cohort] != cohort}
  puts "Students in the #{cohort.capitalize} cohort".center(100)
  students.each_with_index do |student, i| 
    puts "#{i + 1}. #{student[:name]} -- #{student[:location]} -- #{student[:cohort]}".center(100)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(100)
end

students = input_students
print_header
print_students(students)
#print_by_cohort(students, "october")
print_footer(students)