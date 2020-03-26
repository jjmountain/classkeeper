class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  validates :student_id, uniqueness: { scope: :course_id,
    message: "student is already enrolled in class" }

end
