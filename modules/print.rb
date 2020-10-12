module Print
  def header(filename = 'list')
    puts "students in #{filename}".center(50)
    puts '----------------'.center(50)
  end
  
  def students(students)
    students.each do |student|
      puts "#{student[:name]} -- #{student[:cohort]}".center(50)
    end
  end
  
  def csv_files
    print "#{Dir["*.csv"].join(' - ')}\n"
  end
end