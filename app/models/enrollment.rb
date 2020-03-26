class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  validates :student_id, uniqueness: { scope: :course_id,
    message: "student is already enrolled in class" }

  def self.import(file, course_id)
    counter = 0
    CSV.foreach(file.path, headers: true) do |row|
      student = Student.assign_from_row(row)
      if student.save
        counter += 1
      else
        puts "#{student.email} - #{student.errors.full_messages.join(', ')}"
      end
      Enrollment.create(course_id: course_id, student_id: student.id) if student.persisted?
    end
    counter
  end
end
