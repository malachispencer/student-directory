require 'date'

module CreateDirectory
  def add_students
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

    @students
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
  
  def save_students?
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
    filename = validate_filename(STDIN.gets.chomp)
    file = File.open(filename, 'w')
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(', ')
      file.puts csv_line
    end
    file.close
  end
  
  def validate_filename(filename)
    until /^[\w\.\-]+(.csv)$/ === filename
      print 'Valid filename includes letters, numbers'
      print ', underscores, dashes and periods only.'
      puts 'Include extension .csv.'
      filename = STDIN.gets.chomp
    end
    filename
  end
end