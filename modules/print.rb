module Print
  def main_menu
    title = "\nMain menu"
    puts title
    puts '-' * (title.length - 1)
    puts '1. Create new directory'
    puts '2. Show existing directory'
    puts '3. Update existing directory'
    puts '4. Delete existing directory'
    puts '9. Exit'
  end

  def header(filename = 'list')
    title = "\nstudents in #{filename}"
    puts title
    puts '-' * (title.length - 1)
  end
  
  def students(students)
    students.each_with_index do |student,i|
      puts "#{i + 1}. #{student[:name]} -- #{student[:cohort]}"
    end
  end
  
  def csv_files
    dirs = Dir.glob('./directories/*.csv').map {|f| File.basename(f)}
    print "#{dirs.join(' - ')}\n"
  end

  def update_menu
    puts "\nUpdate a directory"
    puts '------------------'
    puts "What would you like to do?"
    puts '1. Rename a directory'
    puts '2. Add students to a directory'
    puts '3. Delete students from a directory'
    puts '9. Go back to main menu'
  end

  def update_instruction(action)
    print "\nEnter directory you would like to #{action}"
    puts ', include file extension in the name.'
  end

  def delete_students_instruction
    puts "\nSelect one or more entries from above to delete, inputs numbers and commas only."
    puts 'For example, if you wish to delete students 1 and 3, enter "1,3".'
  end
end