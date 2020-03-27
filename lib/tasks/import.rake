
namespace :import do
  desc "Import students from csv"
  task students: :environment do 
    counter = 0
    filename = File.join Rails.root, "students.csv"
    CSV.foreach(filename, headers: true) do |row|
      student = Student.assign_from_row(row)
      if student.save
        counter += 1
      else
        puts "#{student.email} - #{student.errors.full_messages.join(', ')}"
      end
    end
    puts "Created #{counter} students!"
  end
end