class Attendance < ApplicationRecord
  belongs_to :lesson
  belongs_to :student
  validates :lesson_id, presence: true
  validates :student_id, presence: true
end
