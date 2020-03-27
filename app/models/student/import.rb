class Student::Import
  include ActiveModel::Model
  attr_accessor :file, :imported_count, :course_id

  def initialize(attributes = {})
    @file = attributes[:file]
    @course_id = attributes[:course_id]
  end

  def process!
    @imported_count = 0
    CSV.foreach(file.path, headers: true) do |row|
      student = Student.assign_from_row(row)
      if student.save
        @imported_count += 1
      else
        errors.add(:base, "Line #{$.} - #{student.errors.full_messages.join(', ')}")
      end
      Enrollment.create(course_id: @course_id, student_id: student.id) if student.persisted?
    end
  end

  def save
    process!
    errors.none?
  end
end