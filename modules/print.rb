module Print
  def main_menu
    puts "\nMain menu"
    puts '---------'
    puts '1. Create new directory'
    puts '2. Show existing directory'
    puts '3. Update existing directory'
    puts '4. Delete existing directory'
    puts '9. Exit'
  end

  def header(filename = 'list')
    title = "\nstudents in #{filename}"
    puts title
    puts '-' * title.length
  end
  
  def students(students)
    students.each do |student|
      puts "#{student[:name]} -- #{student[:cohort]}"
    end
  end
  
  def csv_files
    print "#{Dir["*.csv"].join(' - ')}\n"
  end

  def update_menu
    puts 'Update a directory'
    puts '------------------'
    puts "What would you like to do?"
    puts '1. Rename a directory'
    puts '2. Add students to a directory'
    puts '3. Delete students from a directory'
    puts '9. Go back to main menu'
  end

  def update_instruction(action)
    print "Enter directory you would like to #{action}"
    puts ', include file extension in the name.'
  end
end