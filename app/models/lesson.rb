class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :course_period
  has_many :lesson_sections
  has_many :attendances

end
